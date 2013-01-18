class StolenPhonesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :index

  def index
    @stolen_phones = StolenPhone.search params
    @stolen_phones = @stolen_phones.page params[:page]

    respond_to do |format|
      format.html
      format.json { render json: @stolen_phones }
    end
  end

  def new
    @stolen_phone = StolenPhone.new

    respond_to do |format|
      format.html
      format.json { render json: @stolen_phone }
    end
  end

  def edit
    @stolen_phone = StolenPhone.find(params[:id])
  end

  def create
    @stolen_phone = StolenPhone.new(params[:stolen_phone])

    respond_to do |format|
      if @stolen_phone.save
        format.html { redirect_to stolen_phones_url, notice: 'Stolen phone was successfully created.' }
        format.json { render json: @stolen_phone, status: :created, location: @stolen_phone }
      else
        format.html { render action: "new" }
        format.json { render json: @stolen_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @stolen_phone = StolenPhone.find(params[:id])

    respond_to do |format|
      if @stolen_phone.update_attributes(params[:stolen_phone])
        format.html { redirect_to stolen_phones_url, notice: 'Stolen phone was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stolen_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stolen_phone = StolenPhone.find(params[:id])
    @stolen_phone.destroy

    respond_to do |format|
      format.html { redirect_to stolen_phones_url }
      format.json { head :no_content }
    end
  end
end