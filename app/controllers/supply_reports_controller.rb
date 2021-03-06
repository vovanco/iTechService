class SupplyReportsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    authorize SupplyReport
    @supply_reports = policy_scope(SupplyReport).all.date_desc.page(params[:page])
    respond_to do |format|
      format.html
    end
  end

  def show
    @supply_report = find_record SupplyReport
    respond_to do |format|
      format.html
    end
  end

  def new
    @supply_report = authorize SupplyReport.new
    respond_to do |format|
      format.html { render 'form' }
    end
  end

  def edit
    @supply_report = find_record SupplyReport
    respond_to do |format|
      format.html { render 'form' }
    end
  end

  def create
    @supply_report = authorize SupplyReport.new(params[:supply_report])
    @supply_report.department_id ||= current_department.id

    respond_to do |format|
      if @supply_report.save
        format.html { redirect_to @supply_report, notice: t('supply_reports.created') }
      else
        format.html { render 'form' }
      end
    end
  end

  def update
    @supply_report = find_record SupplyReport
    respond_to do |format|
      if @supply_report.update_attributes(params[:supply_report])
        format.html { redirect_to @supply_report, notice: t('supply_reports.updated') }
      else
        format.html { render 'form' }
      end
    end
  end

  def destroy
    @supply_report = find_record SupplyReport
    @supply_report.destroy
    respond_to do |format|
      format.html { redirect_to supply_reports_url }
    end
  end

  private

  def sort_column
    Order.column_names.include?(params[:sort]) ? params[:sort] : ''
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : ''
  end
end
