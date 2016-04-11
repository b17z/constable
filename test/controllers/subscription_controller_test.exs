defmodule Constable.SubscriptionControllerTest do
  use Constable.ConnCase
  use Bamboo.Test

  alias Constable.Subscription

  setup do
    {:ok, browser_authenticate}
  end
  
  test "#create creates the subscription", %{conn: conn, user: user} do
    announcement = create(:announcement)

    post conn, announcement_subscription_path(conn, :create, announcement.id)

    subscription = Repo.one(Subscription) |> Repo.preload([:user, :announcement])
    assert subscription.user.id == user.id
    assert subscription.announcement.id == announcement.id
  end

  test "#delete deletes  the subscription", %{conn: conn, user: user} do
    announcement = create(:announcement)
    subscription = create(:subscription, user: user, announcement: announcement)

    delete conn, announcement_subscription_path(conn, :delete, announcement.id)

    refute Repo.get(Subscription, subscription.id)
  end
end
