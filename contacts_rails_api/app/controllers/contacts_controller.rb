class ContactsController < ApplicationController

  def index
    owned = params[:user_id]
    all_contacts = []
    all_contacts += [(Contact.find_by user_id: owned)]
    shared = (ContactShare.where("user_id = ?", owned))[0..-1]
    shared.each do |find_contact|
      all_contacts += [Contact.find(find_contact[:contact_id])]
    end

    render json: all_contacts.flatten.uniq
  end

  def show
    contact = Contact.find(params[:id])
    render json: contact
  end

  def create
    contact = Contact.new(contact_params)
    contact.save
    render json: contact
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    render json: contact
  end

  def update
    contact = Contact.find(params[:id])
    contact.update(contact_params)
    render json: contact
  end

  protected

    def contact_params
      params.require(:contact).permit(:name, :email)
    end

end
