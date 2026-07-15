# Experimental!
┌─╴D
  ~ {
    Num
    String
    Map
    Box
    Array
    BoxArray
  }
└─╴

GetLabel    ← ⨬(+@\0↙°⊥₂₅₆⊃↙↘4↘₂|""◌)=0⊣⋯₈⊸⊢binary
DDToMap     ← map⊸⍚GetLabel
IsBoxArray  ← ↧⊃(≍2type)(¬≍[]△)
IsLabeled   ← /↧≡◇(≠0⧻GetLabel)
IsBoxArray₂ ← ⊃(°0=0⧻|°2type)
ReplaceLast ← ˜⌝⊸⊡@:/↥⊚⊸=@_

Mapify ← |1 ⍥(⍥(DDToMap) ⊙⍚(Mapify)⊸IsLabeled)⊸IsBoxArray

FormatMap      ← $"_ [shape=record, label=\"_\"];" ⊙(/$"_ | _"˙⍚$"<_> _"⊙◌°map)
FormatBoxArray ← $"_ [shape=record, label=\"_\"];" ⊙(/$"_ | _"˙⍚$"<_> _"⇡⧻)
FormatOther    ← $"_ [shape=box, image=\"_\", label=\"\"];" ⟜(⟜&fwa $".gvtmp/_.jpg") ⊙(img"jpg" layout 20 pretty$_)

# DOTFormatArray ? DOTFormatArray NameObj Object  
AddNodes ← |3 ⍡(
  ⊂/◇⊂⍚(AddNodes{}) ⍚⌞($"_\__")⊙°map ⤙₂(⊂⊙(□⍩FormatMap))
| ⊂/◇⊂⍚(AddNodes{}) ⍚⌞($"_\__")⊙(°⋕°⊏)⤙₂(⊂⊙(□FormatBoxArray⊙⊸⍩IsBoxArray₂))
| ⊂⊙(□FormatOther))

# DOTFormatArray ? DOTFormatArray
AddEdges ← ⍚($"_ -> _" ⊸ReplaceLast)↘₋₁≡◇(⊢⊜□⊸≠@ )

MakeGraph ← (
  &fmd ".gvtmp"
  Mapify
  "Head"
  {}
  AddNodes
  ⊸AddEdges
  ∩(/$"_\n\t_")
  $"digraph G {\nbgcolor=black;\nnode [fontcolor=white, color=white];\nedge [color=white];\t_\n\t_\n}"
  &fwa ".gvtmp/graph.dot"
  &runs {"dot" "-Tpng" ".gvtmp/graph.dot"}
  ⋅⊙◌
  &rb ∞
  ◌°img
  &ims
  &fde ".gvtmp"
)
