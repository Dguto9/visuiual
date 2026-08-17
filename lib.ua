# Experimental!
GetLabel           ↚ ⨬(+@\0↙°⊥₂₅₆⊃↙↘4↘₂|""◌)=0⊣⋯₈⊸⊢binary
DDToMap            ↚ map⊸⍚GetLabel
IsBoxArray         ↚ ↧⊃(≍2type)(¬≍[]△)
IsLabeled          ↚ /↧≡◇(≠0⧻GetLabel)
ErrorIfNotBoxArray ↚ ⊃(°0=0⧻|°2type)
ReplaceLast        ↚ ˜⌝⊸⊡@:/↥⊚⊸=@_
DedupLabels        ↚ ⍚(˜⊂⨬(°⋕|"")⊸=0)⊸⧆
GenUniqueNames     ↚ ⬚@0⍚(°⋕⌊×ⁿ₁₀10gen[])

GetLabelError    ↚ +@\0↙⍤"No Label"⊸≠0°⊥₂₅₆⊃↙↘4↘₂⍤"No Meta"≠0⊣⋯₈⊸⊢binary
GetNamesGeneric  ↚ ⍡(DedupLabels⍩⍚GetLabelError|⊙◌°⊏)
GetLabelsGeneric ↚ ⍡(⍩⍚GetLabelError|⊙◌°⊏)

Mapify ← |1 ⍥(⍥(DDToMap) ⊙⍚(Mapify)⊸IsLabeled)⊸IsBoxArray

MatchString ↚ ≡◇(/↥≡⌟◇⦷≡⊢⨬(∘|⋅({"\0"}))=0⊸⧻⊸regex"\".*?\"")
MatchDigit  ↚ ≡⌞∊"0123456789"
MatchBox    ↚ =@□
MatchChar   ↚ +⊸≡↻₋₁=@@
MatchColors ↚ ˜⊏⊙(/↥[⊃(×₄MatchString|×₃MatchChar|×₂MatchDigit|MatchBox)])÷₂₅₆≡⧈₂⌞⋕₁₆
LayoutCode  ↚ ×⊃(layout!(°⊸Color White)|≡▽×3/5⟜▽⊙(⧋˜⊂1MatchColors ["d1daec" "95d16a" "f08050" "20f9fc" "20f9fc"]))
FmtObj      ↚ ⍡(▽₂˜÷100/↥⊸△₂ ⍩°1_1≥20⊸△₂⍩⍤"Bad rank"∊2_3_4⧻⊸△⍩°0⊸type|LayoutCode 20 pretty)

FormatMap      ↚ $"_ [shape=none, label=<<TABLE CELLBORDER=\"0\" ROWS=\"*\" CELLSPACING=\"0\" STYLE=\"ROUNDED\">_</TABLE>>];" ⊙(/$"__"⍚$"<TR><TD PORT= \"_\"><IMG SRC=\"_\"/></TD></TR>"⟜⍚(⟜&fwa $".gvtmp/_.png")⊃(GenUniqueNames|⍚(img"png"FmtObj $_))⊙◌⍩°map)
FormatBoxArray ↚ $"_ [shape=Mrecord, label=\"_\"];" ⊙(/$"_ | _"⍚$"<_> _"⊃GetNamesGeneric GetLabelsGeneric)
FormatOther    ↚ $"_ [shape=underline, image=\"_\", label=\"\"];" ⟜(⟜&fwa $".gvtmp/_.png") ⊙(img"png" FmtObj)

# DOTFormatArray ? DOTFormatArray NameObj Object  
AddNodes ↚ |3 ⍡(
  ⊂/◇⊂⍚(AddNodes{}) ⍚⌞($"_\__")⊙(GenUniqueNames°map) ⤙₂(⊂⊙(□FormatMap⊙⊸⍩ErrorIfNotBoxArray))
| ⊂/◇⊂⍚(AddNodes{}) ⍚⌞($"_\__")⊙⊸GetNamesGeneric ⤙₂(⊂⊙(□FormatBoxArray⊙⊸⍩ErrorIfNotBoxArray))
| ⊂⊙(□FormatOther))

# DOTFormatArray ? DOTFormatArray
AddEdges ↚ ⍚($"_ -> _" ⊸ReplaceLast)↘₋₁≡◇(⊢⊜□⊸≠@ )

MakeGraph ← (
  &fmd ".gvtmp"
  {}"Head"
  ⊸AddEdges AddNodes
  ∩(/$"_\n\t_")
  $"digraph G {\nbgcolor=\"#19232d\";\nrankdir=\"LR\";\nnode [fontcolor=white, fontname=\"Uiua386\", color=white];\nedge [color=white];\t_\n\t_\n}"
  &fwa ".gvtmp/graph.dot"
  &runs {"dot" "-Tpng" ".gvtmp/graph.dot"}
  ◌°img&rb∞⋅⊙◌
  &fde ".gvtmp"
)

GV ← &imsMakeGraph
GG ← MakeGraph
