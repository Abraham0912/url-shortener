class LinksController < ApplicationController
  before_action :set_link, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  def index
    @links = Link.where(user_id:current_user.id)

    render json: @links.order(:id)
  end

  def show
    render json: @link
  end

  def create
    @link = Link.new(link_params)
    # @code = SecureRandom.uuid[0..5]
    @code = Digest::SHA256.hexdigest(@link.url)[0..5]
    # @link.code = "http://localhost:3000/s/#{@code}}"
    @link.code = @code
    @link.user_id = current_user.id

    if @link.save
      render json: @link, status: :created, location: @link
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  def update
    @code = Digest::SHA256.hexdigest(@link.url)[0..5]
    @link.code = @code
    if @link.update(link_params)
      render json: @link
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @link.destroy
      render json: {message: "Se elimino correctamente"}
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  def redirect
    @link = Link.find_by_code(params[:code])
    @link.update(count:@link.count+1)
    
    # p "==========================> #{request.remote_ip}"
    # p "===============++++===========> #{request.user_agent}"
    user_agent = UserAgent.parse(request.user_agent)
    View.create(ip_adress: request.remote_ip, browser: user_agent.browser, os: user_agent.platform, link_id: @link.id, created_at:Time.zone.now.to_datetime)
    
    redirect_to @link.url
  end

  private
    def set_link
      @link = Link.find(params[:id])
    end

    #Parametros fuertes 💪
    def link_params
      params.require(:link).permit(:url)
    end
end
