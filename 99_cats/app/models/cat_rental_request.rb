class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :user_id, presence: true
  validates_inclusion_of :status, in: ["PENDING", "APPROVED", "DENIED"]
  validate :start_is_before_end
  validate :start_date_in_future
  validate :overlapping_approved_requests

  belongs_to(
  :submitter,
  class_name: 'User',
  foreign_key: :user_id,
  primary_key: :id
  )

  belongs_to(
  :requested_cat,
  class_name: 'Cat',
  foreign_key: :cat_id,
  primary_key: :id
  )

  def approve!
    if pending?
      CatRentalRequest.transaction do
        overlaps = self.overlapping_requests

        overlaps.each do |request|
          raise "conflicting with already approved" if request.status == "APPROVED"
          request.update!(status: "DENIED")
        end
        self.update!(status:"APPROVED")
      end
    end
  end

  def deny!
    if pending?
      self.update!(status:"DENIED")
    end
  end

  def pending?
    self.status == "PENDING"
  end

  protected

  def overlapping_requests

    sql_query = "SELECT
      cat_rental_requests.*
    FROM
      cats
    JOIN
      cat_rental_requests on cats.id = cat_rental_requests.cat_id
    WHERE
      cat_rental_requests.cat_id = :cat
      AND (cat_rental_requests.start_date BETWEEN :start AND :finish
      OR cat_rental_requests.end_date BETWEEN :start AND :finish)"
    CatRentalRequest.find_by_sql([sql_query,{:cat => self.cat_id,
                                      :id => self.id,
                                      :start => self.start_date,
                                      :finish => self.end_date}])
  end

  private

  def start_date_in_future
    if self.start_date.nil? || self.start_date < Time.now
      return errors[:base] << "Choose a valid start date"
    end
  end

  def start_is_before_end
    if self.start_date.nil? || self.end_date.nil? || self.start_date > self.end_date
      return errors[:base] << "Invalid date range"
    end
  end

  def overlapping_approved_requests
    cats = overlapping_requests
    cats.each do |cat|
      return errors[:base] << "Cat is already rented" if cat.status == "APPROVED"
    end
  end


end
