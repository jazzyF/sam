defmodule Pallet do
  @enforce_keys [:id]
  defstruct weight: 0, id: nil
end

defmodule Trailer do
  defstruct pallets: %{}, weightTrack: %{}

  def getWeight(pallets) do
    pallets
    |> Map.values()
    |> Enum.map(fn x -> x.weight end)
    |> Enum.sum()
  end

  def loadPallet(%Trailer{pallets: pallets, weightTrack: weightTrack}, pallet, time) do
    p = Map.put(pallets, pallet.id, pallet)
    wt = Map.put(weightTrack, time, getWeight(p))
    %Trailer{pallets: p, weightTrack: wt}
  end

  def unloadPallet(%Trailer{pallets: pallets, weightTrack: weightTrack}, id, time) do
    p = Map.delete(pallets, id)
    wt = Map.put(weightTrack, time, getWeight(p))
    %Trailer{pallets: p, weightTrack: wt}
  end
end

p1 = %Pallet{id: 1, weight: 10}
p2 = %Pallet{id: 2, weight: 20}
p3 = %Pallet{id: 3, weight: 30}
p4 = %Pallet{id: 4, weight: 40}

pallets = %{p1.id => p1, p2.id => p2, p3.id => p3, p4.id => p4}

t = %Trailer{pallets: %{}, weightTrack: %{}}

t = Trailer.loadPallet(t, p1, 11)
IO.puts(Trailer.getWeight(t.pallets))
t = Trailer.unloadPallet(t, p1.id, 15)
IO.puts(Trailer.getWeight(t.pallets))
