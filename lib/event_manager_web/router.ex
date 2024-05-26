defmodule EventManagerWeb.Router do
  use EventManagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {EventManagerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EventManagerWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", EventManagerWeb do
    pipe_through :api

    resources "/venues", VenueController, except: [:new, :edit]
    resources "/events", EventController, except: [:new, :edit]
    resources "/map_links", MapLinkController, except: [:new, :edit]
    resources "/members", MemberController, except: [:new, :edit]
    resources "/rsvps", RsvpController, except: [:new, :edit]
    resources "/series", SeriesController, except: [:new, :edit]
    get "/series/:id/events", SeriesController, :list_events
  end

  # Other scopes may use custom stacks.
  # scope "/api", EventManagerWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:event_manager, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: EventManagerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
