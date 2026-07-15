# Experimental!
GetLabel    ← ⨬(+@\0↙°⊥₂₅₆⊃↙↘4↘₂|""◌)=0⊣⋯₈⊸⊢binary
DDToMap     ← map⊸⍚GetLabel
IsBoxArray  ← ↧⊃(≍2type)(¬≍[]△)
IsLabeled   ← /↧≡◇(≠0⧻GetLabel)
IsBoxArray₂ ← ⊃(°0=0⧻|°2type)
ReplaceLast ← ˜⌝⊸⊡@:/↥⊚⊸=@_

Mapify ← |1 ⍥(⍥(DDToMap) ⊙⍚(Mapify)⊸IsLabeled)⊸IsBoxArray

MatchString ← ≡◇(/↥≡⌟◇⦷≡⊢⨬(∘|⋅({"\0"}))=0⊸⧻⊸regex"\".*?\"")
MatchDigit  ← ≡⌞∊"0123456789"
MatchColors ← ˜⊏⊙(↥⊃(×₂MatchString|MatchDigit))÷₂₅₆≡⧈₂⌞⋕₁₆
LayoutCode  ← ×⊃(layout!(°⊸Color White)|≡▽×3/5⟜▽⊙(⧋˜⊂1MatchColors ["d1daec" "f08050""20f9fc"]))

FormatMap      ← $"_ [shape=Mrecord, label=\"_\"];" ⊙(/$"_ | _"˙⍚$"<_> _"⊙◌°map)
FormatBoxArray ← $"_ [shape=Mrecord, label=\"_\"];" ⊙(/$"_ | _"˙⍚$"<_> _"⇡⧻)
FormatOther    ← $"_ [shape=underline, image=\"_\", label=\"\"];" ⟜(⟜&fwa $".gvtmp/_.png") ⊙(img"png" LayoutCode 20 pretty$_)

# DOTFormatArray ? DOTFormatArray NameObj Object  
AddNodes ← |3 ⍡(
  ⊂/◇⊂⍚(AddNodes{}) ⍚⌞($"_\__")⊙°map ⤙₂(⊂⊙(□⍩FormatMap⊙⊸⍩IsBoxArray₂))
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
  $"digraph G {\nbgcolor=\"#19232d\";\nnode [fontcolor=white, color=white];\nedge [color=white];\t_\n\t_\n}"
  &fwa ".gvtmp/graph.dot"
  &runs {"dot" "-Tpng" ".gvtmp/graph.dot"}
  ⋅⊙◌
  &rb ∞
  ◌°img
  &ims
  &fde ".gvtmp"
)
