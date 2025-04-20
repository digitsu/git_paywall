defmodule GitPaywallTest do
  use ExUnit.Case
  doctest GitPaywall

  test "greets the world" do
    assert GitPaywall.hello() == :world
  end
end
