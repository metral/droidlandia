class ApkBinsController < ApplicationController
  # GET /apk_bins
  # GET /apk_bins.json
  def index
    @apk_bins = ApkBin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @apk_bins }
    end
  end

  # GET /apk_bins/1
  # GET /apk_bins/1.json
  def show
    @apk_bin = ApkBin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @apk_bin }
    end
  end

  # GET /apk_bins/new
  # GET /apk_bins/new.json
  def new
    @apk_bin = ApkBin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @apk_bin }
    end
  end

  # GET /apk_bins/1/edit
  def edit
    @apk_bin = ApkBin.find(params[:id])
  end

  # POST /apk_bins
  # POST /apk_bins.json
  def create
    @apk_bin = ApkBin.new()
    @apk_bin.apk = params[:file] if params.has_key?(:file)
    @apk_bin.intent = "fuck off" #params[:intent] if params.has_key?(:intent)
    @apk_bin.save!

    puts "Saving"

    respond_to do |format|
      if @apk_bin.save
        puts "Putting into queue"
        Resque.enqueue(AdbWorker, @apk_bin.id)
        format.html { redirect_to @apk_bin, notice: 'Apk bin was successfully created.' }
        format.json { render json: @apk_bin, status: :created, location: @apk_bin }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @apk_bin.errors, status: :unprocessable_entity }
        format.js
      end

    end
  end

  # PUT /apk_bins/1
  # PUT /apk_bins/1.json
  def update
    @apk_bin = ApkBin.find(params[:id])

    respond_to do |format|
      if @apk_bin.update_attributes(params[:apk_bin])
        format.html { redirect_to @apk_bin, notice: 'Apk bin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @apk_bin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apk_bins/1
  # DELETE /apk_bins/1.json
  def destroy
    @apk_bin = ApkBin.find(params[:id])
    @apk_bin.destroy

    respond_to do |format|
      format.html { redirect_to apk_bins_url }
      format.json { head :no_content }
    end
  end
end
