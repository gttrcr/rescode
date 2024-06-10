(* ::Package:: *)

(* ::Title:: *)
(*TensoriaCalc*)


(* ::Section::Closed:: *)
(*TensoriaCalc: Introduction*)


(* ::Input::Initialization:: *)
(* ============================================== *)
(*            Copyright Yi-Zen Chu.               *)
(* ============================================== *)
(* One main goal of this software is the          *)
(* computation of Christoffel symbols, Riemann,   *)
(* Ricci tensor and scalar, etc. given a specific *)
(* metric. We are working within a Riemannian     *)
(* geometry frameowork. Explicit tensorial        *)
(* calculations will increasingly be supported.   *)
(* ============================================== *)
(* Please feel free to use and/or modify this     *)
(* code for the purposes of scientific research.  *)
(* Please cite the URL below in your publications *)
(* if you do use this code for your research.     *)
(* If you want to make money off this, write to   *)
(* me first at yizen[dot]chu[at]gmail[dot]com.    *)
(* Feel free to send comments to the same e-mail. *)
(* This software, a user's guide, and future      *)
(* updates/revisions should be available at       *)
(* http://www.stargazing.net/yizen/Tensoria.html  *)
(* ============================================== *)
(* While developing this code, I have taken       *)
(* inspiration from the following three software: *)
(* FeynCalc @ http://www.feyncalc.org/            *)
(* grt @ http://www.vaudrevange.com/pascal/grt/   *)
(* xAct @ http://www.xact.es/                     *)
(* ============================================== *)
(* Please refer to the TensoriaCalc.nb file for   *)
(* the definitions of the geometric objects       *)
(* computed by this package. (It is difficult to  *)
(* type the definitions in text.)                 *)


(* ::Section::Closed:: *)
(*Geometric Objects: Definitions*)


(* ::Text:: *)
(*Here, for the user's reference, we define the geometric objects computed by TensoriaCalc. We employ Einstein's summation convention, i.e., repeated indices are summed over.*)


(* ::Text:: *)
(*Our Christoffel symbols are: Subscript[\[CapitalGamma]^\[Alpha], \[Mu]\[Nu]]\[Congruent](1/2)g^\[Alpha]\[Lambda](\!\( *)
(*\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]*)
(*\*SubscriptBox[\(g\), \(\[Nu]\[Lambda]\)]\)+\!\( *)
(*\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]*)
(*\*SubscriptBox[\(g\), \(\[Mu]\[Lambda]\)]\)-\!\( *)
(*\*SubscriptBox[\(\[PartialD]\), \(\[Lambda]\)]*)
(*\*SubscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)). Because \[CapitalGamma] is not a tensor, we do not allow for raising and lowering of indices.*)


(* ::Text:: *)
(*Our Riemann curvature tensor is: Subscript[R^\[Alpha], \[Beta]\[Mu]\[Nu]]\[Congruent]\!\( *)
(*\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]*)
(*\*SubscriptBox[*)
(*SuperscriptBox[\(\[CapitalGamma]\), \(\[Alpha]\)], \(\[Nu]\[Beta]\)]\)-\!\( *)
(*\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]*)
(*\*SubscriptBox[*)
(*SuperscriptBox[\(\[CapitalGamma]\), \(\[Alpha]\)], \(\[Mu]\[Beta]\)]\)+Subscript[\[CapitalGamma]^\[Alpha], \[Sigma]\[Mu]] Subscript[\[CapitalGamma]^\[Sigma], \[Nu]\[Beta]]-Subscript[\[CapitalGamma]^\[Alpha], \[Sigma]\[Nu]] Subscript[\[CapitalGamma]^\[Sigma], \[Mu]\[Beta]]. The Weyl tensor Subscript[C^\[Alpha], \[Beta]\[Mu]\[Nu]] is the traceless part of the Riemann tensor.*)


(* ::Text:: *)
(*The Ricci tensor is: Subscript[R, \[Beta]\[Nu]]\[Congruent]Subscript[R^\[Alpha], \[Beta]\[Alpha]\[Nu]].*)


(* ::Text:: *)
(*The Ricci scalar is: R\[Congruent]g^\[Alpha]\[Beta] Subscript[R, \[Alpha]\[Beta]].*)


(* ::Text:: *)
(*The Einstein tensor is: Subscript[G, \[Beta]\[Nu]]\[Congruent]Subscript[R, \[Beta]\[Nu]] - Subscript[g, \[Beta]\[Nu]]R/2.*)


(* ::Text:: *)
(*The generally covariant Levi-Civita tensor, in d space(time) dimensions, is Subscript[\!\(\*OverscriptBox[\(\[Epsilon]\), \(~\)]\), Subscript[\[Mu], 1]... Subscript[\[Mu], d]]=(|det Subscript[g, \[Alpha]\[Beta]]|)^(1/2) Subscript[\[Epsilon], Subscript[\[Mu], 1]... Subscript[\[Mu], d]], where Subscript[\[Epsilon], Subscript[\[Mu], 1]... Subscript[\[Mu], d]] is the Levi-Civita symbol, which in turn returns the sign of the permutation that brings {Subscript[\[Mu], 1,...,] Subscript[\[Mu], d]} into {0,1,2,3,..., d-1} (or into {Subscript[s, i]+1,Subscript[s, i]+2,Subscript[s, i]+3,...,Subscript[s, i]+d}, for some integer Subscript[s, i]) and is zero otherwise. In flat spacetime, this means we adhere to the covention that Subscript[\!\(\*OverscriptBox[\(\[Epsilon]\), \(~\)]\), 0123...d-1] =1 regardless of the signature of the metric. Note: Mathematica has a built-in LeviCivitaTensor that appears to implement what we would call the Levi-Civita tensor in d-dimensional flat Euclidean space in Cartesian coordinates.*)


(* ::Text:: *)
(*The Hodge dual (aka Hodge star operation), in d space(time) dimensions, of a fully antisymmetric tensor Subscript[A, Subscript[\[Mu], 1]... Subscript[\[Mu], n]] (where n <= d), is defined as, for e.g., *)
(*		\[FivePointedStar]Subscript[A, Subscript[\[Mu], 1]... Subscript[\[Mu], d-n]]\[Congruent](1/n!)Subscript[\!\(\*OverscriptBox[\(\[Epsilon]\), \(~\)]\), Subscript[\[Mu], 1]... Subscript[\[Mu], d-n] Subscript[\[Nu], 1]... Subscript[\[Nu], n]]A^(Subscript[\[Nu], 1]... Subscript[\[Nu], n]).*)


(* ::Section:: *)
(*Public*)


(* ::Subsection::Closed:: *)
(*Begin*)


(* ::Input::Initialization:: *)
BeginPackage["TensoriaCalc`"];
(* Upper indices are denoted by, e.g. \[Mu]^-. Lower indices are denoted by, e.g. Subscript[\[Mu], -] *)
(* This notation is the same as Pascal's gtr *)


(* ::Subsection::Closed:: *)
(*?Usage*)


(* ::Input::Initialization:: *)
(* Usage allows us to say which functions will be `public' *)
Tensor::usage="Tensor is the generic Head of all tensorial objects.";
TensorType::usage="TensorType specifies the type of Tensor.";
TensorName::usage="TensorName specifies the name of Tensor.";
Indices::usage="(I) Indices \[Rule] {\[Mu],\[Nu],...} is one of the arguments of Tensor. It defines the indices of the Tensor. An upper index carries a superscript '-' and a lower index a subscript '-'. For example \!\(\*SuperscriptBox[\(\[Alpha]\), \(-\)]\) (also equivalent to SuperMinus[\[Alpha]]) is an upper index and \!\(\*SubscriptBox[\(\[Alpha]\), \(-\)]\) (also equivalent to SubMinus[\[Alpha]]) is a lower index. (II) Indices[M_Tensor] takes in a Tensor and returns a List of the indices used.";
Metric::usage="(\!\(\*
StyleBox[\"I\",\nFontColor->RGBColor[0, 0, 1]]\)) Metric[\[Mu],\[Nu],M,CoordinateSystem\[Rule]coords_List,TensorName\[Rule]name,StartIndex\[Rule]i,ChristoffelOperator\[Rule]op,RiemannOperator\[Rule]op,RicciOperator\[Rule]op,RicciScalarOperator\[Rule]op] returns a Tensor object representing a metric M with indices \[Mu] and \[Nu] (either both upper, i.e., \!\(\*SuperscriptBox[\(\[Mu]\), \(-\)]\) and \!\(\*SuperscriptBox[\(\[Nu]\), \(-\)]\), or both lower, i.e. \!\(\*SubscriptBox[\(\[Mu]\), \(-\)]\) and \!\(\*SubscriptBox[\(\[Nu]\), \(-\)]\); the coordinates are specified through the List coords. The name of the metric is name, and the metric M itself can either be given as a square matrix or an expression quadratic in differentials of the coordinates (e.g. (\[DifferentialD]x\!\(\*SuperscriptBox[\()\), \(2\)]\)+(\[DifferentialD]y\!\(\*SuperscriptBox[\()\), \(2\)]\)). StartIndex i tells TensoriaCalc when to begin counting indices; for example spacetime indices usually start at 0 while spatial indices usually start at 1. The ChristoffelOperator, RiemannOperator, etc. specify operators that will be applied to the components of the Christoffel symbols, Riemann tensor, etc. (Note: TensorName, StartIndex, ChristoffelOperator, RiemannOperator, RicciOperator, RicciScalarOperator are optional; the defaults are name = \!\(\*
StyleBox[\"g\",\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\",\",\nFontSlant->\"Italic\"]\) i = 0 and op = FullSimplify.) (\!\(\*
StyleBox[\"II\",\nFontColor->RGBColor[0, 0, 1]]\)) Metric[\[Mu], \[Nu], \[Tau]_Tensor] takes in \[Tau], an object with Head Tensor, of TensorType Metric, and returns the same Tensor object with TensorComponents representing the metric (if \[Mu],\[Nu] are both SuperMinus), the inverse metric (if \[Mu],\[Nu] are both SubMinus), or the identity matrix (if one index is SubMinus and one is SuperMinus).";
(*  *)
NonMetricTensor::usage="NonMetricTensor[\[Mu]_List,stuff_List,exp_,CoordinateSystem\[Rule]coords_List,TensorName\[Rule]Unique[T],TensorType\[Rule]Null,TooltipDisplay\[Rule]Null,
	StartIndex\[Rule]0] returns a Tensor with indices \[Mu], components (entered as a Table) stuff, TensorName \[Rule] exp, coordinates coords, etc. TensorName, TensorType, TooltipDisplay, and StartIndex are Optional arguments, with default values as shown.";
Riemann::usage="Riemann[\[Mu],\[Nu],\[Alpha],\[Beta],MetricT] takes in the metric MetricT and returns a Tensor containing the components of the Riemann curvature tensor, if indices are Symbols. If indices are Integers or if indices are the coordinates, the specified component will be returned.";
Ricci::usage="Ricci[\[Nu],\[Beta],MetricT_Tensor] takes in the Tensor MetricT and returns a Tensor containing the components of the Ricci curvature tensor, if indices are Symbols. If indices are Integers or if indices are the coordinates, the specified component will be returned.";
RicciScalar::usage="RicciScalar[MetricT] takes in the Tensor MetricT and returns the Ricci scalar.";
Einstein::usage="Einstein[\[Nu],\[Beta],MetricT_Tensor,EinsteinOperator\[Rule]op] takes in the Tensor MetricT and returns a Tensor containing (the operation op applied to) the components of the Einstein tensor, where Einstein-Tensor = Ricci-Tensor - (Metric-Tensor/2) Ricci-Scalar \[LongDash] if indices are Symbols. If indices are Integers or if indices are the coordinates, the specified component will be returned. (EinsteinOperator is optional; if left unspecified, the default is op = FullSimplify.)";
LeviCivita::usage="LeviCivita[\[Nu]1,\[Nu]2,...,\[Nu]d,MetricT_Tensor] takes in the Tensor MetricT (in \!\(\*
StyleBox[\"d\",\nFontSlant->\"Italic\"]\) dimensions) and return a Tensor that yields the generally covariant Levi-Civita volume form, with indices \[Nu]1 through \[Nu]d. Note that Mathematica has an in-built LeviCivitaTensor, but it is really our LeviCivita here implemented for flat (Euclidean) space.";
CovariantHodgeDual::usage="CovariantHodgeDual[\[Nu]I__,\[Tau]_Tensor,m_Tensor] returns the generally covariant Hodge dual of the Tensor \[Tau] using the Metric Tensor m. Note that Mathematica has an in-built HodgeDual, but it is really the Hodge dual (aka Hodge star operator) in flat (Euclidean) space. Now, the Hodge dual (aka Hodge star operation), in \!\(\*FormBox[\(d\),
TraditionalForm]\) space(time) dimensions, of a fully antisymmetric tensor \!\(\*FormBox[SubscriptBox[\(A\), \(\(\*SubscriptBox[\(\[Mu]\), \(1\)] ... \) \*SubscriptBox[\(\[Mu]\), \(n\)]\)],
TraditionalForm]\) (where \!\(\*FormBox[\(n\\\  \[LessEqual] \\\ d\),
TraditionalForm]\)), is defined as, for e.g., \[FivePointedStar]\!\(\*FormBox[SubscriptBox[\(A\), \(\(\*SubscriptBox[\(\[Mu]\), \(1\)] ... \) \*SubscriptBox[\(\[Mu]\), \(d - n\)]\)],
TraditionalForm]\)\[Congruent]\!\(\*FormBox[\((1/\(n!\))\),
TraditionalForm]\)\!\(\*FormBox[SubscriptBox[OverscriptBox[\(\[Epsilon]\), \(~\)], \(\(\(\*SubscriptBox[\(\[Mu]\), \(1\)] ... \) \*SubscriptBox[\(\[Mu]\), \(d - n\)] \*SubscriptBox[\(\[Nu]\), \(1\)] ... \) \*SubscriptBox[\(\[Nu]\), \(n\)]\)],
TraditionalForm]\)\!\(\*FormBox[SuperscriptBox[\(A\), \(\(\*SubscriptBox[\(\[Nu]\), \(1\)] ... \) \*SubscriptBox[\(\[Nu]\), \(n\)]\)],
TraditionalForm]\). Note: CovariantHodgeDual does check whether the Tensor \[Tau] is fully antisymmetric.";
EinsteinOperator::usage="EinsteinOperator->op is an Option when using the TensoriaCalc function Einstein. It tells TensoriaCalc to apply op to the components of the Einstein tensor. The default op = FullSimplify.";
Weyl::usage="Weyl[\[Mu],\[Nu],\[Alpha],\[Beta],MetricT_Tensor] takes in the metric MetricT and returns a Tensor containing the components of the Weyl curvature tensor, if indices are Symbols. If indices are Integers or if indices are the coordinates, the specified component will be returned.";
WeylOperator::usage="WeylOperator->op is an Option when using the TensoriaCalc function Weyl. It tells TensoriaCalc to apply op to the components of the Weyl curvature tensor. The default op = FullSimplify.";
CoordinateSystem::usage="CoordinateSystem defines the variables used in a given coordinate system. For example CoordinateSystem \[Rule] {t,x,y,z}.";
Coordinates::usage="Coordinates[M_Tensor] takes in a Tensor of type Metric and returns a List of the coordinates used.";
TensorComponents::usage="(I) TensorComponents \[Rule] tt is one of the arguments of Tensor. It defines the components for a given Tensor through tt. (II) TensorComponents[m_Tensor] takes in a Tensor object m and returns its TensorComponents";
MetricDeterminant::usage="MetricDeterminant is an Option within a Tensor of type Metric whose OptionValue is the determinant of the metric in use.";
Determinant::usage="Determinant[MetricT] takes in a Tensor of type Metric and returns the determinant of the metric."
RiemannComponents::usage="RiemannComponents refer to the components of the Riemann curvature tensor.";
RicciComponents::usage="RicciComponents refer to the components of the Ricci curvature tensor.";
RicciScalarInvariant::usage="RicciScalarCurvature is the Option occuring within a Tensor of Metric type, whose OptionValue gives the rule referring to the Ricci scalar.";
ChristoffelComponents::usage="ChristoffelComponents refer to the components of the Christoffel symbols.";
StartIndex::usage="StartIndex is the Option occuring within Tensor that tells TensoriaCalc which Integer to start counting indices from. For example, spacetime indices usually have StartIndex \[Rule] 0 whereas purely spatial indices usually have StartIndex \[Rule] 1.";
Christoffel::usage="Christoffel[SuperMinus[\[Mu]_Integer],SubMinus[\[Alpha]_Integer],SubMinus[\[Beta]_Intger],M_Tensor] takes in the metric Tensor M (TensorType must be Metric) and returns a Tensor containing the components of the Christoffel symbol, if indices are Symbols. If indices are Integers or if indices are the coordinates, the specified component will be returned.";
TooltipDisplay::usage="TooltipDisplay is an Option occuring within a non-Metric type Tensor which tells TensoriaCalc what to display when the user hovers her mouse over the Tensor.";
ChristoffelOperator::usage="ChristoffelOperator \[Rule] Op is an Option when using Metric. It tells TensoriaCalc to apply Op when calculating the components of the Christoffel symbols, for example FullSimplify the resulting expression.";
RiemannOperator::usage="RiemannOperator \[Rule] Op is an Option when using Metric. It tells TensoriaCalc to apply Op when calculating the components of the Riemann curvature tensor, for example FullSimplify the resulting expression.";
RicciOperator::usage="RicciOperator \[Rule] Op is an Option when using Metric. It tells TensoriaCalc to apply Op when calculating the components of the Ricci curvature tensor, for example FullSimplify the resulting expression.";
RicciScalarOperator::usage="RicciScalarOperator \[Rule] Op is an Option when using Metric. It tells TensoriaCalc to apply Op when calculating the components of the Ricci scalar, for example FullSimplify the resulting expression.";
CovariantBox::usage="CovariantBox[X,MetricT] applies the operator \!\(\*SuperscriptBox[\(g\), \(\[Mu]\[Nu]\)]\) \!\(\*SubscriptBox[\(\[Del]\), \(\[Mu]\)]\)\!\(\*SubscriptBox[\(\[Del]\), \(\[Nu]\)]\) on X using the metric Tensor MetricT. Currently, only the scalar operator is supported, i.e. X cannot contain Tensor objects and CovariantBox[X,MetricT] \[Congruent] (|det g|\!\(\*SuperscriptBox[\()\), \(1/2\)]\)\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]\)((|det g|\!\(\*SuperscriptBox[\()\), \(1/2\)]\) \!\(\*SuperscriptBox[\(g\), \(\[Mu]\[Nu]\)]\) \!\(\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]\)X).";
CoordinateTransformation::usage="(I.1) CoordinateTransformation[{x\[Rule]f1[x,y,z,...], y\[Rule]f2[x,y,z,...], z\[Rule]f3[x,y,z,...], ...}] returns the coordinate transformation and the associated Jacobian for the infinitesimals, i.e. the output is Union[{x\[Rule]f1[x,y,z,...], y\[Rule]f2[x,y,z,...], z\[Rule]f3[x,y,z,...], ...}, {dx\[Rule](\[PartialD]f1/\[PartialD]x)\[DifferentialD]x+(\[PartialD]f1/\[PartialD]y)\[DifferentialD]y+ ..., dy\[Rule](\[PartialD]f2/\[PartialD]x)\[DifferentialD]x+(\[PartialD]f2/\[PartialD]y)\[DifferentialD]y+...}]. 
	(I.2) CoordinateTransformation[{x\[Rule]f1[p,q,r,...], y\[Rule]f2[p,q,r,...], z\[Rule]f3[p,q,r,...], ...}, {p,q,r, ...}] returns the coordinate transformation and the associated Jacobian for the infinitesimals, i.e. the output is Union[{x\[Rule]f1[p,q,r,...], y\[Rule]f2[p,q,r,...], z\[Rule]f3[p,q,r,...], ...}, {dx\[Rule](\[PartialD]f1/\[PartialD]p)\[DifferentialD]p+(\[PartialD]f1/\[PartialD]q)\[DifferentialD]q+ ..., dy\[Rule](\[PartialD]f2/\[PartialD]p)\[DifferentialD]p+(\[PartialD]f2/\[PartialD]q)\[DifferentialD]q+...}]. The main difference between (I.1) and (I.2) is that (I.2) allows for new coordinate names on the right hand side of the rules; of course, that means one has to specify what the new coordinates are for (I.2). (II) CoordinateTransformation[mt_Tensor,{x\[Rule]f1[x,y,z,...], y\[Rule]f2[x,y,z,...], z\[Rule]f3[x,y,z,...], ...}, CoordinateTransformationOperator\[Rule]op] or CoordinateTransformation[{x\[Rule]f1[p,q,r,...], y\[Rule]f2[p,q,r,...], z\[Rule]f3[p,q,r,...], ...}, {p,q,r, ...}, CoordinateTransformationOperator\[Rule]op], where mt is a Tensor of TensorType Metric, returns the same Tensor mt except coordinate-transformed according to the specified rules. Note that the index names and placement (i.e., down-down or up-up) are preserved. The CoordinateTransformationOperator\[Rule]op is an optional rule; with the default op = FullSimplify. Note: the StartIndex will be brought over from the input Metric mt; and the new coordinates will be ordered according to the chronology specified in {p,q,r,...}.";
GradientSquared::usage="GradientSquared[X,MetricT] computes \!\(\*SuperscriptBox[\(g\), \(\[Mu]\[Nu]\)]\) \!\(\*SubscriptBox[\(\[Del]\), \(\[Mu]\)]\)X \!\(\*SubscriptBox[\(\[Del]\), \(\[Nu]\)]\)X using the metric Tensor MetricT. Currently, only the scalar operator is supported, i.e. X cannot contain Tensor objects.";
PartialD::usage="PartialD[\!\(\*SubscriptBox[\(\[Mu]\), \(-\)]\),S_Tensor,MetricT_Tensor] (or PartialD[\!\(\*SuperscriptBox[\(\[Mu]\), \(-\)]\),S_Tensor,MetricT_Tensor]) returns a Tensor object with TensorComponents \!\(\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]\)TensorComponent[S] (or \!\(\*SuperscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]\)TensorComponent[S]), using the metric \!\(\*SuperscriptBox[\(g\), \(\[Mu]\[Nu]\)]\) of MetricT.";
CovariantD::usage="CovariantD[\!\(\*SubscriptBox[\(\[Mu]\), \(-\)]\),S_Tensor,MetricT_Tensor] (or CovariantD[\!\(\*SuperscriptBox[\(\[Mu]\), \(-\)]\),S_,MetricT_Tensor]) returns a Tensor object with TensorComponents containing the metric-compatible covariant derivative \!\(\*SubscriptBox[\(\[Del]\), \(\[Mu]\)]\) (or \!\(\*SuperscriptBox[\(\[Del]\), \(\[Mu]\)]\)) acting on S, using the metric MetricT.";
ContractTensors::usage="ContractTensors[Times[tt__Tensor]] \[LongDash] not to be confused with Mathematica's own TensorContract \[LongDash] returns a Tensor whose TensorComponents is built from contracting the sequence of Tensors in tt, i.e., by forming a tensor product out of their TensorComponents, and summing over repeated indices. All other attributes of the output Tensor are inherited from the first Tensor of the sequence in tt.";
SwapIndices::usage="SwapIndices[tt_Tensor,idx_List] returns the Tensor object tt, with its un-UnderBarred indices (say, \!\(\*SubscriptBox[\(i\), \(1\)]\)...\!\(\*SubscriptBox[\(i\), \(n\)]\)) re-arranged into idx; the TensorComponents of tt are re-arranged accordingly. When specifying idx, remember not to include the UnderBarred Indices of tt.";
TensorIsZero::usage="TensorIsZero[tt_Tensor] returns True if every component of the Tensor object tt is zero and False otherwise.";
MoveIndices::usage="(I) MoveIndices[tt_Tensor,idx_List,m_Tensor] returns the Tensor tt with its indices raised/lowered by specifying idx, using the Metric Tensor m. Suppose tt has indices {\!\(\*FormBox[SubscriptBox[\(\[Alpha]\), \(-\)],
TraditionalForm]\), \!\(\*FormBox[SuperscriptBox[\(\[Beta]\), \(-\)],
TraditionalForm]\) ,\!\(\*FormBox[SuperscriptBox[\(\[Mu]\), \(-\)],
TraditionalForm]\), \!\(\*FormBox[SubscriptBox[\(\[Nu]\), \(-\)],
TraditionalForm]\)} and \[Alpha] and \[Mu] need to be raised and lowered respectively, then do MoveIndices[tt_Tensor,{\!\(\*FormBox[\(\*SuperscriptBox[\(\[Alpha]\), \(-\)], \*SubscriptBox[\(\[Mu]\), \(-\)]\),
TraditionalForm]\)},m]. (II) MoveIndices[tt_Tensor,m_Tensor] essentially returns the Tensor tt[\[Alpha],\[Beta],...] where the indices \[Alpha],\[Beta],... can be specified arbitrarily \[LongDash] either up or down. If the specified indices were not in the same up/down position as the input tt, the indices are automatically moved using the Metric Tensor m.";
RaiseAllIndices::usage="RaiseAllIndices[tt_Tensor,m_Tensor] returns the Tensor tt with all its indices raised using the Metric Tensor m.";
LowerAllIndices::usage="LowerAllIndices[tt_Tensor,m_Tensor] returns the Tensor tt with all its indices lowered using the Metric Tensor m.";
UniqueIndices::usage="UniqueIndices[tt_Tensor] returns the Tensor tt with its indices replaced with Unique ones.";
GeodesicSystem::usage="GeodesicSystem[MetricT_Tensor,AffineParameter\[Rule]\[Lambda],NonAffineParameter\[Rule]t] returns the affine parameter Lagrangian (1/2)\!\(\*SubscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)[z[\[Lambda]]](\!\(\*SuperscriptBox[\(dz\), \(\[Mu]\)]\)/d\[Lambda])(\!\(\*SuperscriptBox[\(dz\), \(\[Nu]\)]\)/d\[Lambda]) for geodesic motion, the non-affine parameter Lagrangian (\!\(\*SubscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)[z[t]](\!\(\*SuperscriptBox[\(dz\), \(\[Mu]\)]\)/dt)(\!\(\*SuperscriptBox[\(dz\), \(\[Nu]\)]\)/dt)\!\(\*SuperscriptBox[\()\), \(1/2\)]\) for geodesic motion, and the geodesic equations in both affine and non-affine parameter forms.";
GeodesicLagrangians::usage="GeodesicLagrangians[MetricT_Tensor,AffineParameter\[Rule]\[Lambda],NonAffineParameter\[Rule]t] returns the affine parameter Lagrangian (1/2)\!\(\*SubscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)[z[\[Lambda]]](\!\(\*SuperscriptBox[\(dz\), \(\[Mu]\)]\)/d\[Lambda])(\!\(\*SuperscriptBox[\(dz\), \(\[Nu]\)]\)/d\[Lambda]) for geodesic motion, and the non-affine parameter Lagrangian (\!\(\*SubscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)[z[t]](\!\(\*SuperscriptBox[\(dz\), \(\[Mu]\)]\)/dt)(\!\(\*SuperscriptBox[\(dz\), \(\[Nu]\)]\)/dt)\!\(\*SuperscriptBox[\()\), \(1/2\)]\) for geodesic motion. It does what GeodesicSystem does, but does not output the geodesic equations themselves.";
GeodesicHamiltonianDynamics::usage="GeodesicHamiltonianDynamics[MetricT_Tensor,{z1->p1,z2->p2,...},\[Lambda]] returns the affine parameter Hamiltonian (1/2)\!\(\*SuperscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)[z[\[Lambda]]]\!\(\*SubscriptBox[\(p\), \(\[Mu]\)]\)[\[Lambda]]\!\(\*SubscriptBox[\(p\), \(\[Nu]\)]\)[\[Lambda]] 
	and the geodesic equations {\!\(\*SuperscriptBox[\(dz\), \(\[Mu]\)]\)/d\[Lambda]==\!\(\*SuperscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)\!\(\*SubscriptBox[\(p\), \(\[Nu]\)]\),\!\(\*SubscriptBox[\(dp\), \(\[Mu]\)]\)=-\[PartialD]H/\[PartialD]\!\(\*SuperscriptBox[\(z\), \(\[Mu]\)]\)}.";
LieDerivative::usage="LieDerivative[\[Xi]_Tensor,m_Tensor] returns the Lie derivative of the Tensor m with respect to the rank-1 Tensor \[Xi]. Currently, LieDerivative only takes in Metric m; i.e., it only computes the Lie derivatives of metrics: \!\(\*SubscriptBox[\(\[Sterling]\), \(\[Xi]\)]\)\!\(\*SubscriptBox[\(g\), \(\[Mu]\[Nu]\)]\) = \!\(\*SuperscriptBox[\(\[Xi]\), \(\[Sigma]\)]\)\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Sigma]\)]\)\!\(\*SubscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)+\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]\)\!\(\*SuperscriptBox[\(\[Xi]\), \(\[Sigma]\)]\)\!\(\*SubscriptBox[\(g\), \(\[Nu]\[Sigma]\)]\)+\!\(\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]\)\!\(\*SuperscriptBox[\(\[Xi]\), \(\[Sigma]\)]\)\!\(\*SubscriptBox[\(g\), \(\[Mu]\[Sigma]\)]\).";


(* ::Input::Initialization:: *)
(* 4D Ideal MHD Functions *)
MHDSystem::usage="MHDSystem[{\[CapitalPhi]1_,\[CapitalPhi]2_,\[CapitalPhi]3_}, \[Rho]0_Function, m_Tensor, MetricSignature \[Rule] s_String, MHDOperator \[Rule] op] returns an object, with Head MHDSystem, that stores all relevant information described by the 3 scalar fields {\[CapitalPhi]1,\[CapitalPhi]2,\[CapitalPhi]3} and the plasma energy density (pure function) \[Rho]0. Note that MetricSignature and MHDOperator are optional; s = `Mostly minus' tells TensoriaCalc the user employs \!\(\*SubscriptBox[\(\[Eta]\), \(\[Mu]\[Nu]\)]\) = diag[1,-1,...,-1] and s = `Mostly plus' tells TensoriaCalc the user employs \!\(\*SubscriptBox[\(\[Eta]\), \(\[Mu]\[Nu]\)]\) = diag[-1,+1,...,+1]; the default values are s = `Mostly minus' and op = Simplify.";
MHDScalar::usage="(\!\(\*
StyleBox[\"I\",\nFontColor->RGBColor[0, 0, 1]]\)) MHDScalar[1,mm_MHDSystem], MHDScalar[2,mm_MHDSystem], and MHDScalar[3,mm_MHDSystem] returns, respectively, the 1st, 2nd, and 3rd fundamental scalar fields of the MHDSystem mm. (\!\(\*
StyleBox[\"II\",\nFontColor->RGBColor[0, 0, 1]]\)) MHDScalar[\[Mu]T_,1,mm_MHDSystem], MHDScalar[\[Mu]T_,2,mm_MHDSystem], and MHDScalar[\[Mu]T_,3,mm_MHDSystem] returns, respectively, the Tensor object describing \[Del]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\), \[Del]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\), and \[Del]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\), with index \[Mu]T.";
MHD3Form::usage="MHD3Form[\[Mu]T_,\[Nu]T_,\[Gamma]T_,mm_MHDSystem] returns the Tensor built from the 3 fundamental scalars \!\(\*
StyleBox[OverscriptBox[
StyleBox[\"n\",\nFontSlant->\"Italic\"], \"~\"],\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\" \",\nFontSlant->\"Italic\"]\)\[Congruent] \[DifferentialD]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\) \[Wedge] \[DifferentialD]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\) \[Wedge] \[DifferentialD]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\), of the MHDSystem mm, with indices {\[Mu]T,\[Nu]T,\[Gamma]T}.";
MHDPlasmaCurrent::usage="MHDPlasmaCurrent[\[Mu]T_,mm_MHDSystem] returns the plasma current Tensor \!\(\*
StyleBox[\"n\",\nFontSlant->\"Italic\"]\), of the MHDSystem mm, with indices {\[Mu]T}. Note that \!\(\*
StyleBox[\"n\",\nFontSlant->\"Italic\"]\) is the Hodge dual of the 3-form built from the 3 fundamental MHD scalars, namely \[DifferentialD]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\) \[Wedge] \[DifferentialD]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\) \[Wedge] \[DifferentialD]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\).";
MHDMaxwell::usage="MHDMaxwell[\[Mu]T_,\[Nu]T_,mm_MHDSystem] returns the Maxwell Tensor \!\(\*
StyleBox[\"F\",\nFontSlant->\"Italic\"]\), of the MHDSystem mm, with indices {\[Mu]T,\[Nu]T}.";
MHDMaxwellCurrent::usage="MHDMaxwellCurrent[\[Mu]T_,mm_MHDSystem] returns the electromagnetic (Maxwell) current \!\(\*
StyleBox[\"J\",\nFontSlant->\"Italic\"]\) = div \!\(\*
StyleBox[\"F\",\nFontSlant->\"Italic\"]\), of the MHDSystem mm, with index {\[Mu]T}.";
MHDRank2P::usage="MHDRank2P[\[Mu]T_,\[Nu]T_,mm_MHDSystem] returns the rank-2 Tensor object \!\(\*
StyleBox[\"P\",\nFontSlant->\"Italic\"]\), of the MHDSystem mm, with indices {\[Mu]T,\[Nu]T}. This \!\(\*
StyleBox[\"P\",\nFontSlant->\"Italic\"]\) occurs on the right hand side of the 3 MHD PDEs.";
MHDMetric::usage="MHDMetric[\[Mu]T_, \[Nu]T_, mm_MHDSystem] returns the Metric Tensor object describing the background spacetime geometry of the MHDSystem in mm, with indices {\[Mu]T, \[Nu]T}.";
(* ... MHDSystem arguments *)
MHDScalarFunction1::usage="MHDScalarFunction1 \[Rule] \!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\) is one of the arguments of an MHDSystem object. It describes the 1st fundamental scalar of the MHDSstem.";
MHDScalarFunction2::usage="MHDScalarFunction2 \[Rule] \!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\) is one of the arguments of an MHDSystem object. It describes the 2nd fundamental scalar of the MHDSstem.";
MHDScalarFunction3::usage="MHDScalarFunction3 \[Rule] \!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\) is one of the arguments of an MHDSystem object. It describes the 3rd fundamental scalar of the MHDSstem.";
MHD1FormTensor1::usage="MHD1FormTensor1 \[Rule] \[Del]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\) is one of the arguements of an MHDSystem object. It describes the gradient of the 1st fundamental scalar of the MHDSstem.";
MHD1FormTensor2::usage="MHD1FormTensor2 \[Rule] \[Del]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\) is one of the arguements of an MHDSystem object. It describes the gradient of the 2nd fundamental scalar of the MHDSstem.";
MHD1FormTensor3::usage="MHD1FormTensor3 \[Rule] \[Del]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\) is one of the arguements of an MHDSystem object. It describes the gradient of the 3rd fundamental scalar of the MHDSstem.";
MHD3FormTensor::usage="MHD3FormTensor \[Rule] \[Del]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\)\[Wedge]\[Del]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\)\[Wedge]\[Del]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\) is one of the arguments of an MHDSystem object. It describes the 3-form \[DifferentialD]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\)\[Wedge]\[DifferentialD]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\)\[Wedge]\[DifferentialD]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\), where \!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(I = 1, 2, 3\)]\) are the 3 fundamental scalars of the MHDSystem.";
MHDMaxwellTensor::usage="MHDMaxwellTensor \[Rule] \[Del]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\)\[Wedge]\[Del]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\) is one of the arguments of an MHDSystem object. It describes the 2-form Maxwell Tensor \!\(\*
StyleBox[\"F\",\nFontSlant->\"Italic\"]\) = \[DifferentialD]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\)\[Wedge]\[DifferentialD]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\), where \!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(I = 1, 2\)]\) are the first 2 fundamental scalars of the MHDSystem.";
MHDPlasmaCurrentTensor::usage="MHDPlasmaCurrentTensor \[Rule] \[FivePointedStar](\[DifferentialD]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\) \[Wedge] \[DifferentialD]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\) \[Wedge] \[DifferentialD]\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\)) is one of the arguments of an MHDSystem object. It describes the (identically conserved) plasma current Tensor, which in index notation reads \!\(\*SuperscriptBox[
StyleBox[\"n\",\nFontSlant->\"Italic\"], \(\[Mu]\)]\) \[Congruent] \!\(\*SuperscriptBox[OverscriptBox[\(\[Epsilon]\), \(~\)], \(\[Mu]\\\ \[Alpha]\[Beta]\[Gamma]\)]\) \!\(\*SubscriptBox[\(\[Del]\), \(\[Alpha]\)]\)\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\)\!\(\*SubscriptBox[\(\[Del]\), \(\[Beta]\)]\)\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\)\!\(\*SubscriptBox[\(\[Del]\), \(\[Gamma]\)]\)\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\), where \!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(I = 1, 2, 3\)]\) are the 3 fundamental scalars of the MHDSystem.";
MHDRank2PTensor::usage="MHDRank2PTensor \[Rule] \!\(\*FormBox[SuperscriptBox[\(P\), \(\[Alpha]\[Beta]\)],
TraditionalForm]\) is one of the arguments of an MHDSystem object. It describes the Tensor object \!\(\*SuperscriptBox[
StyleBox[\"P\",\nFontSlant->\"Italic\"], \(\[Alpha]\[Beta]\)]\) \[Congruent] \!\(\*SubscriptBox[\(\[Del]\), \(\[Sigma]\)]\)(\!\(\*SubscriptBox[\(\[Rho]\), \(0\)]\) \!\(\*SuperscriptBox[\(\[Del]\), \([\[Sigma]\)]\)\!\(\*SubscriptBox[\(\[CapitalPhi]\), \(1\)]\) \!\(\*SuperscriptBox[\(\[Del]\), \(\[Alpha]\)]\)\!\(\*SubscriptBox[\(\[CapitalPhi]\), \(2\)]\) \!\(\*SuperscriptBox[\(\[Del]\), \(\(\[Beta]\)\(]\)\)]\)\!\(\*SubscriptBox[\(\[CapitalPhi]\), \(3\)]\)), which occurs on the right-hand-sides of the 3 PDEs governing the MHDSystem.";
MHDMaxwellCurrentTensor::usage="MHDMaxwellCurrentTensor \[Rule] \!\(\*FormBox[SuperscriptBox[\(J\), \(\[Alpha]\)],
TraditionalForm]\) is one of the arguments of an MHDSystem object. It describes the Tensor object \!\(\*SuperscriptBox[
StyleBox[\"J\",\nFontSlant->\"Italic\"], \(\[Alpha]\)]\) \[Congruent] \!\(\*SubscriptBox[\(\[Del]\), \(\[Sigma]\)]\)\!\(\*SuperscriptBox[
StyleBox[\"F\",\nFontSlant->\"Italic\"], \(\[Sigma]\[Alpha]\)]\), \!\(\*
StyleBox[\"i\",\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\".\",\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\"e\",\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\".\",\nFontSlant->\"Italic\"]\), the electromagnetic current.";
MHDEquationsList::usage="MHDEquationsList \[Rule] {{lhs1,rhs1},{lhs2,rhs2},{0,rhs3}} is one of the arguments of an MHDSystem object. The lhs1 == rhs1, lhs2 == rhs2, and 0 == rhs3 form the 3 fundamental PDEs of the MHDSystem.";
MHDEquations::usage="MHDEquations[mm_MHDSystem] returns a List of the 3 fundamental partial differential equations of the MHDSystem mm.";
MHDMaxwellStressTensor::usage="MHDMaxwellStressTensor \[Rule] \!\(\*
StyleBox[\"T\",\nFontSlant->\"Italic\"]\)[EM\!\(\*SubscriptBox[\(]\), \(\[Mu]\[Nu]\)]\) is one of the arguments of an MHDSystem object. It contains the rank-2 Tensor object describing electromagnetic energy-momentum-shear-stress of the MHDSystem.";
MHDPlasmaStressTensor::usage="MHDPlasmaStressTensor \[Rule] \!\(\*
StyleBox[\"T\",\nFontSlant->\"Italic\"]\)[Plasma\!\(\*SubscriptBox[\(]\), \(\[Mu]\[Nu]\)]\) is one of the arguments of an MHDSystem object. It contains the rank-2 Tensor object describing plasma energy-momentum-shear-stress of the MHDSystem.";
MHDTotalStressTensor::usage="MHDTotalStressTensor \[Rule] \!\(\*
StyleBox[\"T\",\nFontSlant->\"Italic\"]\)[Total\!\(\*SubscriptBox[\(]\), \(\[Mu]\[Nu]\)]\) is one of the arguments of an MHDSystem object. It contains the rank-2 Tensor object describing the total plasma + Maxwell photon energy-momentum-shear-stress of the MHDSystem.";
MHDLagrangianDensity::usage="MHDLagrangianDensity \[Rule] L is one of the arguments of a MHDSystem object, where L is the Lagrangian density of the MHDSystem";
MHDPlasmaEnergyDensityOperator::usage="MHDPlasmaEnergyDensityOperator \[Rule] \!\(\*
StyleBox[\"op\",\nFontSlant->\"Italic\"]\) is one of the arguments of a MHDSystem object, where \!\(\*
StyleBox[\"op\",\nFontSlant->\"Italic\"]\) provides the function describing the energy density of the plasma.";
MHDPlasmaEnergyDensity::usage="MHDPlasmaEnergyDensity[mm_MHDSystem] returns the plasma energy density function of the MHDSystem mm.";
MHDLagrangian::usage="MHDLagrangian[mm_MHDSystem] returns the (coordinate scalar) Lagrangian density of the MHDSystem mm.";
MHDEnergyMomentumShearStress::usage="MHDEnergyMomentumShearStress[\[Mu]T_,\[Nu]T_,ss_String,mm_MHDSystem], for ss = Maxwell, returns the rank-2 Tensor object describing electromagnetic energy-momentum-shear-stress of the MHDSystem mm. MHDEnergyMomentumShearStress[\[Mu]T_,\[Nu]T_,ss_String,mm_MHDSystem], for ss = Plasma, returns the rank-2 Tensor object describing plasma energy-momentum-shear-stress of the MHDSystem mm. MHDEnergyMomentumShearStress[\[Mu]T_,\[Nu]T_,ss_String,mm_MHDSystem], for ss = Total, returns the rank-2 Tensor object describing the total plasma + Maxwell photon energy-momentum-shear-stress of the MHDSystem mm.";
MHDMetricTensor::usage="MHDMetricTensor \[Rule] \!\(\*SubscriptBox[
StyleBox[\"g\",\nFontSlant->\"Italic\"], \(\[Mu]\[Nu]\)]\) is one of the arguments of an MHDSystem object. It contains the rank-2 Tensor object describing background spacetime geometry of the MHDSystem.";
MHDOperator::usage="MHDOperator \[Rule] op is an optional argument when entering a MHDSystem. Default value for op is Simplify.";
MetricSignature::usage="MetricSignature \[Rule] op_String specifies whether the user is employing the `Mostly minus' or `Mostly plus' metric signature; in (1+1) spacetime dimensions `Mostly minus' means \!\(\*SubscriptBox[\(\[Eta]\), \(\[Mu]\[Nu]\)]\) \[Congruent] diag[1,-1] and `Mostly plus' means \!\(\*SubscriptBox[\(\[Eta]\), \(\[Mu]\[Nu]\)]\) \[Congruent] diag[-1,1]. MetricSignature occurs, for e.g., as an Optional argument in MHDSystem. Whenever relevant, the default is `Mostly minus'.";


(* ::Subsection::Closed:: *)
(*Attributes/Options/Mathematica Packages*)


(* ::Input::Initialization:: *)
(* Tensor properties/options *)
SetAttributes[Tensor,Orderless];
SetAttributes[MHDSystem,Orderless];
Options[Metric]={CoordinateSystem->{},TensorName->"\!\(\*
StyleBox[\"g\",\nFontSlant->\"Italic\"]\)",StartIndex->0,ChristoffelOperator->Simplify,RiemannOperator->Simplify,RicciOperator->Simplify,RicciScalarOperator->Simplify};
Options[Einstein]={EinsteinOperator->Simplify};
Options[Weyl]={WeylOperator->Simplify};
Options[NonMetricTensor]={StartIndex->0,TooltipDisplay->Null,TensorType->Null};
Options[MHDSystem]={MHDOperator->Simplify,MetricSignature->"Mostly minus"};
Options[GeodesicSystem]={AffineParameter->Unique[\[CapitalTHacek]],NonAffineParameter->Unique[\[CapitalLSlash]]};
Options[GeodesicLagrangians]={AffineParameter->Unique[\[CapitalTHacek]],NonAffineParameter->Unique[\[CapitalLSlash]]};
Options[CoordinateTransformation]={CoordinateTransformationOperator->FullSimplify};
(* MMA Packages *)
Needs["VariationalMethods`"];


(* ::Section::Closed:: *)
(*Start Private here*)


(* ::Input::Initialization:: *)
Begin["`Private`"];


(* ::Section::Closed:: *)
(*Internal Programming Tools*)


(* ::Input::Initialization:: *)
(* check if \[Mu] is an index *)
CheckIndex[\[Mu]_]:=MatchQ[\[Mu],SuperMinus[_Integer]]||MatchQ[\[Mu],SuperMinus[_Symbol]]||MatchQ[\[Mu],SubMinus[_Integer]]||MatchQ[\[Mu],SubMinus[_Symbol]];
(* \[Mu]^- gives +1 and Subscript[\[Mu], -] gives -1 *)
Sgn[\[Mu]_]:=Which[
(* upper index *)
MatchQ[\[Mu],SuperMinus[_]],1,
(* lower index *)
MatchQ[\[Mu],SubMinus[_]],-1
]/;CheckIndex[\[Mu]];
(* \[Mu]^- or Subscript[\[Mu], -] returns \[Mu] *)
IndexNumber[\[Mu]_]:=\[Mu][[1]]/;CheckIndex[\[Mu]];
(* \[Mu]^- returns Column[{\[Mu],Null}], i.e. upper index *)
(* Subscript[\[Mu], -] returns Column[{Null,\[Mu]}], i.e. lower index *)
UpOrDown[\[Mu]_]:=Which[
(* lower index *)
MatchQ[\[Mu],SubMinus[_]],Column[{Null,\[Mu][[1]]}],
(* upper index *)
MatchQ[\[Mu],SuperMinus[_]],Column[{\[Mu][[1]],Null}]
];
(* ReplaceIndex: takes in \[Nu] and (\[Mu]^- or Subscript[\[Mu], -]), and returns (\[Nu]^- or Subscript[\[Nu], -]) *)
ReplaceIndex[\[Nu]_/;((Head[\[Nu]]===Symbol)||(Head[\[Nu]]===Integer)),\[Mu]_/;CheckIndex[\[Mu]]]:=Which[
(* upper index *)
MatchQ[\[Mu],SuperMinus[_]],SuperMinus[\[Nu]],
(* lower index *)
MatchQ[\[Mu],SubMinus[_]],SubMinus[\[Nu]]
];
(* returns #^- or Subscript[#, -] given coordinates cooo and StartIndex st, where # is the appropriate index number *)
(* if the \[Mu]I is just a Symbol w/o any other meaning, it will be returned as is. *)
NumericIndex[\[Mu]I_/;CheckIndex[\[Mu]I],cooo_List,st_]:=Which[
(* if it's already an Integer then just return itself *)
Head[\[Mu]I[[1]]]===Integer,\[Mu]I,
(* if it is one of the coordinates return the Position *)
Intersection[{\[Mu]I[[1]]},cooo]==={\[Mu]I[[1]]},
	ReplaceIndex[((Flatten[Position[cooo,\[Mu]I[[1]]]])[[1]]-1+st),\[Mu]I],
(* if neither then just return original stuff *)
True,\[Mu]I
];
(* RaiseLower[\[Mu],\[Nu],\[Tau]] gives KroneckerDelta if \[Mu] and \[Nu] have the same Sgn and otherwise g^{\[Mu]\[Nu]} or g_{\[Mu]\[Nu]} *)
(* right index is the index on the Tensor *)
(* left index is what we want *)
(* if they are both upper or lower, then we need to return \[Delta] *)
(* if ud, then return g^{-1} *)
(* if du, then return g *)
RaiseLower[\[Mu]_/;CheckIndex[\[Mu]],\[Nu]_/;CheckIndex[\[Nu]],\[Tau]_Tensor]/;((Cases[\[Tau],(TensorType->ttt_)->ttt]==={"Metric"})&&(MatchQ[Flatten[Cases[\[Tau],(Indices->ttt_)->ttt]],{SuperMinus[_],SuperMinus[_]}]||MatchQ[Flatten[Cases[\[Tau],(Indices->ttt_)->ttt]],{SubMinus[_],SubMinus[_]}])):=Module[
{si,MetricM},
si=Cases[\[Tau],(StartIndex->ss_)->ss][[1]];
(* read in the metric *)
MetricM=Cases[\[Tau],(TensorComponents->mm_)->mm][[1]];
Which[
(* same sign *)
Sgn[\[Mu]]Sgn[\[Nu]]===1,
	KroneckerDelta[IndexNumber[\[Mu]],IndexNumber[\[Nu]]],
(* \[Mu] positive, \[Nu] negative *)
(* g^{\[Mu] \[Nu]} *)
(* extract inverse metric *)
(Sgn[\[Mu]]===1)&&(Sgn[\[Nu]]===-1),
	Which[
		(* inverse metric *)
		MatchQ[Flatten[Cases[\[Tau],(Indices->ttt_)->ttt]],{SuperMinus[_],SuperMinus[_]}],
		MetricM,
		(* metric *)
		MatchQ[Flatten[Cases[\[Tau],(Indices->ttt_)->ttt]],{SubMinus[_],SubMinus[_]}],
		Inverse[MetricM]
	][[IndexNumber[\[Mu]]-si+1,IndexNumber[\[Nu]]-si+1]],
(* \[Mu] negative, \[Nu] positive *)
(* g_{\[Mu] \[Nu]} *)
(* extract metric *)
(Sgn[\[Mu]]==-1)&&(Sgn[\[Nu]]==1),
	Which[
		(* inverse metric *)
		MatchQ[Flatten[Cases[\[Tau],(Indices->ttt_)->ttt]],{SuperMinus[_],SuperMinus[_]}],
		Inverse[MetricM],
		(* metric *)
		MatchQ[Flatten[Cases[\[Tau],(Indices->ttt_)->ttt]],{SubMinus[_],SubMinus[_]}],
		MetricM
	][[IndexNumber[\[Mu]]-si+1,IndexNumber[\[Nu]]-si+1]]
]
];
(* CheckMetric checks that the metric expression *)
(* is quadratic in the differentials of the coordinates *)
CheckMetric[ss_,cc_List]:=Module[
{dx,\[Epsilon],out},
(* introduce power counting rule *)
dx=((\[DifferentialD]#->\[Epsilon] \[DifferentialD]#)& /@cc);
out=FullSimplify[D[(ss/.dx),\[Epsilon]]/(ss \[Epsilon]),{\[Epsilon]>0}];
Which[
	(* check if ss is quadratic in \[Epsilon] *)
	out===2,True,
	(* if ambiguous or false, return False *)
	True,False
]
];
(* CheckMetricTensor checks that m is a Tensor of the type Metric *)
CheckMetricTensor[m_Tensor]:=Module[{tt},(Cases[m,(TensorType->tt_)->tt,\[Infinity]]==={"Metric"})];
(* CollectRepeatedIndices takes in two or more Lists of Indices and returns all repeated ones *)
CollectRepeatedIndices[ll__List]/;(Union[CheckIndex/@Join[ll]]==={True}):=Cases[Split[Sort[(#[[1]]&/@Join[ll])]],{ss_Symbol,ss_Symbol}->ss];
(* NotAbstractIndex takes in an index \[Mu], a List of coordinates cooo, and start index si, and returns True if the index is not abstract and False otherwise *)
(* Note: start index is needed because sometimes the Index is given as an Integer^- or Subscript[Integer, -] *)
(* The index can be UnderBarred or not *)
NotAbstractIndex[\[Mu]_,cooo_List,si_Integer]:=((CheckIndex[\[Mu]]&&(Intersection[{NumericIndex[\[Mu],cooo,si][[1]]},Range[si,Length[cooo]+si-1]]==={NumericIndex[\[Mu],cooo,si][[1]]})));
(* ScalarTest reads in a Tensor and determines whether it is a scalar by checking *)
(* (1) If Indices are empty {} (2) if all Indices are UnderBarred *)
(* returns True if Tensor is scalar and False otherwise *)
ScalarTest[m_Tensor]:=(Indices[m]==={})||MatchQ[Indices[m],{(SuperMinus|SubMinus)[UnderBar[_]]..}];
(* RemoveUnderBarredIndices remove all UnderBarred Indices *)
RemoveUnderBarredIndices[\[Mu]T_List]:=Module[{xx1,xx2},DeleteCases[\[Mu]T,SuperMinus[UnderBar[xx1_]]|SubMinus[UnderBar[xx2_]]]];
(* RemoveRepeatedUnderBarredIndices remove all repeated UnderBarred Indices *)
RemoveRepeatedUnderBarredIndices[\[Mu]T_List]:=Module[{\[Mu],i1,i2,i3},(\[Mu]T//.{i1___,SuperMinus[UnderBar[\[Mu]_]],i2___,SubMinus[UnderBar[\[Mu]_]],i3___}->{i1,i2,i3})//.{i1___,SubMinus[UnderBar[\[Mu]_]],i2___,SuperMinus[UnderBar[\[Mu]_]],i3___}->{i1,i2,i3}];
(* NestedDel takes in an express of the form Del[...Del[stuff]] and returns {# of Dels, stuff} *)
(* By stuff we simply mean the remainder after the outer most Del's are peeled away; there could still be Del's hidden in output *)
NestedDel[dd_Del]:=Module[{stuff,idx},
stuff=dd;idx=0;
While[
Head[stuff]===Del,
(* strip off outer most Del's *)
stuff=stuff[[1]];idx=idx+1;
];
{idx,stuff}
];
(* FormatTensorName formats the TensorName of a Tensor object *)
FormatTensorName[name_]:=Which[
(* If it is a TensorProduct we put a parenthesis around it *)
Head[name]===TensorProduct,MatrixForm[{name}],
(* If it is a CovariantD we put a parenthesis around it *)
Head[name]===Del,MatrixForm[{name}],
True,name];


(* ::Section:: *)
(*Library of Functions*)


(* ::Subsection:: *)
(*Tensor is the central object*)


(* ::Subsubsection::Closed:: *)
(*Tensor Code*)


(* ::Input::Initialization:: *)
(* Metric *)
(* this is how we are going to input a metric and compute geometric objects *)
Tensor/:Tensor[
TensorType->"Metric",
TensorName->name_,
StartIndex->si_Integer/;si>=0,
Indices->{\[Mu]T_/;(CheckIndex[\[Mu]T]&&(Head[\[Mu]T[[1]]]===Symbol)),\[Nu]T_/;(CheckIndex[\[Nu]T]&&(Head[\[Nu]T[[1]]]===Symbol))},
CoordinateSystem->coords_List/;MatchQ[Dimensions[coords],{_Integer}],
TensorComponents->matrix_/;MatchQ[Dimensions[matrix],{nn_,nn_}],
ChristoffelOperator->ChrisOp_,
RiemannOperator->RiemannOp_,
RicciOperator->RicciOp_,
RicciScalarOperator->RicciSOp_
]/;(MatchQ[{\[Mu]T,\[Nu]T},{SubMinus[_],SubMinus[_]}]||MatchQ[{\[Mu]T,\[Nu]T},{SuperMinus[_],SuperMinus[_]}]):=Module[
{Detg,MetricT,MetricM,Ch,RiemannP,Riemann,RicciT,RicciS,Metric,MetricInv,
	\[Alpha],\[Beta],\[Mu],\[Nu],d,\[Lambda],\[Sigma],coord,gInv,
	RiemannRules,RicciTensorRules,RicciScalarRule,ChristoffelRules},
(* "load" the metric *)
MetricM=Which[
(* lower indices *)
MatchQ[{\[Mu]T,\[Nu]T},{SubMinus[_],SubMinus[_]}],
matrix,
(* upper indices *)
MatchQ[{\[Mu]T,\[Nu]T},{SuperMinus[_],SuperMinus[_]}],
Inverse[matrix]
];
d=Length[coords];
(* for internal computation here, we set StartIndex \[Rule] 0 *)
coord[\[Alpha]_]:=coords[[\[Alpha]+1]];
(* tools to compute tensor components *)
Detg=Simplify[Det[MetricM]];
Metric[\[Mu]_,\[Nu]_]:=MetricM[[\[Mu]+1,\[Nu]+1]];
MetricInv[\[Mu]_,\[Nu]_]:=Inverse[MetricM][[\[Mu]+1,\[Nu]+1]];
Ch[\[Mu]_,\[Alpha]_,\[Beta]_]:=1/2 Sum[MetricInv[\[Mu],\[Lambda]](D[Metric[\[Beta],\[Lambda]],coord[\[Alpha]]]+D[Metric[\[Alpha],\[Lambda]],coord[\[Beta]]]-D[Metric[\[Alpha],\[Beta]],coord[\[Lambda]]]),{\[Lambda],0,d-1}];
RiemannP[\[Alpha]_,\[Beta]_,\[Mu]_,\[Nu]_]:=D[Ch[\[Alpha],\[Beta],\[Nu]],coord[\[Mu]]]+Sum[Ch[\[Alpha],\[Mu],\[Sigma]]Ch[\[Sigma],\[Beta],\[Nu]],{\[Sigma],0,d-1}];
Riemann[\[Alpha]_,\[Beta]_,\[Mu]_,\[Nu]_]:=RiemannP[\[Alpha],\[Beta],\[Mu],\[Nu]]-RiemannP[\[Alpha],\[Beta],\[Nu],\[Mu]];
RicciT[\[Beta]_,\[Nu]_]:=Sum[Riemann[\[Mu],\[Beta],\[Mu],\[Nu]],{\[Mu],0,d-1}];RicciS:=Sum[MetricInv[\[Beta],\[Nu]]RicciT[\[Beta],\[Nu]],{\[Beta],0,d-1},{\[Nu],0,d-1}];
(* start from the empty List *)
RiemannRules={};RicciTensorRules={};ChristoffelRules={};
(* "Do" the computation and save as rules *)
Do[Metric[\[Mu],\[Nu]]=Metric[\[Mu],\[Nu]],{\[Mu],0,d-1},{\[Nu],0,d-1}];
Do[MetricInv[\[Mu],\[Nu]]=MetricInv[\[Mu],\[Nu]],{\[Mu],0,d-1},{\[Nu],0,d-1}];
Do[Ch[\[Mu],\[Alpha],\[Beta]]=ChrisOp[Ch[\[Mu],\[Alpha],\[Beta]]];ChristoffelRules=Append[ChristoffelRules,{ChristoffelComponents[SuperMinus[(si+\[Mu])],SubMinus[(si+\[Alpha])],SubMinus[(si+\[Beta])]]->Ch[\[Mu],\[Alpha],\[Beta]]}],
{\[Mu],0,d-1},{\[Alpha],0,d-1},{\[Beta],0,d-1}];
	Do[
Riemann[\[Alpha],\[Beta],\[Mu],\[Nu]]=RiemannOp[Riemann[\[Alpha],\[Beta],\[Mu],\[Nu]]];
RiemannRules=Append[RiemannRules,{RiemannComponents[SuperMinus[(si+\[Alpha])],SubMinus[(si+\[Beta])],SubMinus[(si+\[Mu])],SubMinus[(si+\[Nu])]]->Riemann[\[Alpha],\[Beta],\[Mu],\[Nu]]}],
{\[Mu],0,d-1},{\[Nu],0,d-1},{\[Alpha],0,d-1},{\[Beta],0,d-1}];
	Do[
RicciT[\[Beta],\[Nu]]=RicciOp[RicciT[\[Beta],\[Nu]]];
RicciTensorRules=Append[RicciTensorRules,{RicciComponents[SubMinus[(si+\[Beta])],SubMinus[(si+\[Nu])]]->RicciT[\[Beta],\[Nu]]}],
{\[Beta],0,d-1},{\[Nu],0,d-1}];
	RicciS=RicciSOp[RicciS];
RicciScalarRule={RicciScalar->RicciS};
Tensor[
TensorType->"Metric",
TensorName->name,
StartIndex->si,
Indices->{\[Mu]T,\[Nu]T},
CoordinateSystem->coords,
TensorComponents->matrix,
MetricDeterminant->Detg,
ChristoffelComponents->Flatten[ChristoffelRules],
RiemannComponents->Flatten[RiemannRules],
RicciComponents->Flatten[RicciTensorRules],
RicciScalarInvariant->Flatten[RicciScalarRule]
]
];
(* Metric: If one up and one down index TensorName is changed to \[Delta] *)
(* this is also good reminder that going to one up one down indices throws away info on the metric itself *)
Tensor/:Tensor[
xx___,
TensorType->"Metric",
Indices->{i1_,i2_}/;((* one up and one down *)Sgn[i1]Sgn[i2]===-1),
TensorName->name_/;((name=!="\!\(\*
StyleBox[\"\[Delta]\",\nFontSlant->\"Italic\"]\)")&&(name=!="\[Delta]"))
]:=Tensor[xx,TensorType->"Metric",Indices->{i1,i2},TensorName->"\[Delta]"];


(* ::Input::Initialization:: *)
(* Series expansion on geometric quantities; Normal is applied to get rid of the O sign *)
(* Need to remember to apply Series on Tooltipdisplay stuff too. *)
(* Metric related *)
Tensor/:Series[Tensor[
xx___,
TensorType->"Metric",
TensorComponents->matrix_,
MetricDeterminant->Detg_,
ChristoffelComponents->ChrisRules_,
RiemannComponents->RiemRules_,
RicciComponents->RicRules_,
RicciScalarInvariant->RRule_
],\[Epsilon]__List]:=Tensor[
xx,
TensorType->"Metric",
TensorComponents->Normal[Series[matrix,\[Epsilon]]],
MetricDeterminant->Normal[Series[Detg,\[Epsilon]]],
ChristoffelComponents->ChrisRules/.(ChristoffelComponents[chx__]->rhs_):>(ChristoffelComponents[chx]->Normal[Series[rhs,\[Epsilon]]]),
RiemannComponents->RiemRules/.(RiemannComponents[riex__]->rhs_):>(RiemannComponents[riex]->Normal[Series[rhs,\[Epsilon]]]),
RicciComponents->RicRules/.(RicciComponents[ricx__]->rhs_):>(RicciComponents[ricx]->Normal[Series[rhs,\[Epsilon]]]),
RicciScalarInvariant->RRule/.(RicciScalar->rhs_):>(RicciScalar->Normal[Series[rhs,\[Epsilon]]])
];
(* Non-Metric, Does not contain TooltipDisplay *)
Tensor/:Series[Tensor[
xx___/;(Cases[{xx},TooltipDisplay,\[Infinity]]==={}),
TensorType->type_/;type=!="Metric",
TensorComponents->matrix_
],\[Epsilon]__List]:=Tensor[
xx,
TensorType->type,
TensorComponents->Normal[Series[matrix,\[Epsilon]]]
];
(* Non-Metric, Contains TooltipDisplay *)
Tensor/:Series[Tensor[
xx___,
TensorType->type_/;type=!="Metric",
TensorComponents->matrix_,
TooltipDisplay->disp_
],\[Epsilon]__List]:=Module[{},
Tensor[
xx,
TensorType->type,
TensorComponents->Normal[Series[matrix,\[Epsilon]]],
TooltipDisplay->(disp/.Rule[lhs_,rhs_]:>Rule[lhs,Normal[Series[rhs,\[Epsilon]]]])
]
];


(* ::Input::Initialization:: *)
(* Evaluating abstract indices at specific coordinates/values *)
(* IofII: If all Indices are either Integers or Coordinates we return the component *)
(* we need to include the possibility that there may be an UnderBar applied to some of the indices *)
(* No UnderBarred Indices *)
Tensor/:Tensor[
xxx___,
CoordinateSystem->cooo_List,
StartIndex->si_Integer,
Indices->\[Mu]T_List,
TensorComponents->matrix_
]:=matrix[[Sequence@@((NumericIndex[#,cooo,si][[1]]-si+1)&/@\[Mu]T)]]/;(Union[NotAbstractIndex[#,cooo,si]&/@\[Mu]T]==={True});
(* If there are more than 1 UnderBarred Indices and all Indices are not abstract then all those indices not UnderBarred are subject to the operations in IIofII below, until all indices are UnderBarred *)
(* So what remains is to deal with a Tensor with all UnderBarred Indices *)
(* All UnderBarred Indices *)
Tensor/:Tensor[
xxx___,
CoordinateSystem->cooo_List,
StartIndex->si_Integer,
Indices->\[Mu]T_List/;MatchQ[\[Mu]T,{(SuperMinus|SubMinus)[UnderBar[_]]..}],
TensorComponents->matrix_
]:=(* if all Indices are UnderBarred there should be only one component *)Which[Head[matrix]===List,matrix[[1]],True,matrix]/;(((* first remove repeated indices then remove all UnderBar's to first check no indices are abstract ones *)Union[NotAbstractIndex[#/.UnderBar[aa_]->aa,cooo,si]&/@RemoveRepeatedUnderBarredIndices[\[Mu]T]]==={True})||(RemoveRepeatedUnderBarredIndices[\[Mu]T]==={}));
(* IIofII: If one or more Indices -- but not all of them -- are Integer or coordinates we reduce the rank of the Tensor accordingly *)
Tensor/:Tensor[
xxx___,
CoordinateSystem->cooo_List,
StartIndex->si_Integer,
Indices->{i1___,\[Mu]T_,i2___},
TensorComponents->matrix_
]:=Module[{mtx,ni,VectorJ,ix,leftidx},
(* contract with Subscript[\[Delta]^\[Mu], ni] or Subscript[\[Delta], \[Mu] ni] *)
ni=NumericIndex[\[Mu]T,cooo,si][[1]];
(* Subscript[\[Delta]^\[Mu], ni] or Subscript[\[Delta], \[Mu] ni] *)
VectorJ=Table[Which[ni===ix,1,True,0],{ix,si,Length[cooo]+si-1}];
(* we are going to contract Tensor with Subscript[\[Delta]^\[Mu], ni] or Subscript[\[Delta], \[Mu] ni] *)
mtx=TensorProduct[VectorJ,matrix];
(* ... do not include indices that do not pass CheckIndex ensuring that sequential Tensor reduction is OK -- i.e., no infinite recursion occurs -- as long as the UnderBar is applied to the said index after TensorContract is applied *)
leftidx=DeleteCases[{i1},xx_/;CheckIndex[xx]===False];
mtx=TensorContract[mtx,{{1,Length[leftidx]+2}}];
(* return the Tensor w/ everything the same except the TensorComponents and the index \[Mu]T *)
Tensor[
xxx,
CoordinateSystem->cooo,
StartIndex->si,
Indices->{i1,UnderBar/@\[Mu]T,i2},
TensorComponents->mtx
]
]/;(CheckIndex[\[Mu]T]&&(* check the index is not abstract *)NotAbstractIndex[\[Mu]T,cooo,si]);


(* ::Input::Initialization:: *)
(* Einstein summation: Repeated indices are summed over *)
(* w/ Tooltipdisplay*)
Tensor/:Tensor[
xxx___,
TooltipDisplay->ttdd_,
CoordinateSystem->cooo_List,
StartIndex->si_Integer,
Indices->{i1___,\[Mu]1T_,i2___,\[Mu]2T_,i3___},
TensorComponents->matrix_
]:=Module[{mtx,MJ,ix1,ix2,leftidx1,leftidx2},
(* Remember to remove underbarred indices because they are no longer part of the active index structue *)
mtx=TensorContract[matrix,{{Length[RemoveUnderBarredIndices[{i1}]]+1,Length[RemoveUnderBarredIndices[{i1}]]+1+Length[RemoveUnderBarredIndices[{i2}]]+1}}];
(* return the Tensor w/ everything the same except the TensorComponents and the indics \[Mu]1T and \[Mu]2T *)
Tensor[
xxx,
CoordinateSystem->cooo,
StartIndex->si,
Indices->{i1,UnderBar/@\[Mu]1T,i2,UnderBar/@\[Mu]2T,i3},
TensorComponents->mtx,
TooltipDisplay->Which[Cases[ttdd,matrix,\[Infinity]]==={},ttdd,True,ttdd/.matrix->mtx]]]/;(((* check repeated indices *)\[Mu]1T[[1]]===\[Mu]2T[[1]])&&((* check one index up and one down *)Sgn[\[Mu]1T]Sgn[\[Mu]2T]===-1)&&(((* check that both indices are abstract *)Position[{si,Length[cooo]+si-1},(* if \[Mu]1T is a coordinate this will return a SuperMinus[number] or SubMinus[number] *)NumericIndex[\[Mu]1T,cooo,si][[1]]]==={}))&&(((* check that both indices are abstract *)Position[{si,Length[cooo]+si-1},(* if \[Mu]2T is a coordinate this will return a SuperMinus[number] or SubMinus[number] *)NumericIndex[\[Mu]2T,cooo,si][[1]]]==={}))&&CheckIndex[\[Mu]1T]&&CheckIndex[\[Mu]2T]);
(* w/o Tooltipdisplay*)
Tensor/:Tensor[
xxx___/;Union[Flatten[Cases[{xxx},TooltipDisplay->nnn_,\[Infinity]]]]==={},
CoordinateSystem->cooo_List,
StartIndex->si_Integer,
Indices->{i1___,\[Mu]1T_,i2___,\[Mu]2T_,i3___},
TensorComponents->matrix_
]:=Module[{mtx,MJ,ix1,ix2,leftidx1,leftidx2},
(* Remember to remove underbarred indices because they are no longer part of the active index structue *)
mtx=TensorContract[matrix,{{Length[RemoveUnderBarredIndices[{i1}]]+1,Length[RemoveUnderBarredIndices[{i1}]]+1+Length[RemoveUnderBarredIndices[{i2}]]+1}}];
(* return the Tensor w/ everything the same except the TensorComponents and the indics \[Mu]1T and \[Mu]2T *)
Tensor[
xxx,
CoordinateSystem->cooo,
StartIndex->si,
Indices->{i1,UnderBar/@\[Mu]1T,i2,UnderBar/@\[Mu]2T,i3},
TensorComponents->mtx]]/;(((* check repeated indices *)\[Mu]1T[[1]]===\[Mu]2T[[1]])&&((* check one index up and one down *)Sgn[\[Mu]1T]Sgn[\[Mu]2T]===-1)&&(((* check that both indices are abstract *)Position[{si,Length[cooo]+si-1},(* if \[Mu]1T is a coordinate this will return a SuperMinus[number] or SubMinus[number] *)NumericIndex[\[Mu]1T,cooo,si][[1]]]==={}))&&(((* check that both indices are abstract *)Position[{si,Length[cooo]+si-1},(* if \[Mu]2T is a coordinate this will return a SuperMinus[number] or SubMinus[number] *)NumericIndex[\[Mu]2T,cooo,si][[1]]]==={}))&&CheckIndex[\[Mu]1T]&&CheckIndex[\[Mu]2T]);


(* ::Input:: *)
(*(* Old code *)
(*(* Einstein summation: Repeated indices are summed over *)*)
(*(* w/ Tooltipdisplay*)*)
(*Tensor/:Tensor[*)
(*xxx___,*)
(*TooltipDisplay\[Rule]ttdd_,*)
(*CoordinateSystem\[Rule]cooo_List,*)
(*StartIndex\[Rule]si_Integer,*)
(*Indices\[Rule]{i1___,\[Mu]1T_,i2___,\[Mu]2T_,i3___},*)
(*TensorComponents\[Rule]matrix_*)
(*]:=Module[{mtx,MJ,ix1,ix2,leftidx1,leftidx2},*)
(*MJ=IdentityMatrix[Length[cooo]];*)
(*(* we are going to contract Tensor with Subscript[\[Delta]^\[Mu]1, \[Mu]2] or Subscript[\[Delta]^\[Mu]2, \[Mu]1] *)*)
(*mtx=TensorProduct[MJ,matrix];*)
(*(* ... do not include indices that do not pass CheckIndex ensuring that sequential Tensor reduction is OK as long as the UnderBar is applied to the said index after TensorContract is applied *)*)
(*leftidx1=DeleteCases[{i1},xx_/;CheckIndex[xx]===False];*)
(*leftidx2=DeleteCases[{i2},xx_/;CheckIndex[xx]===False];*)
(*mtx=TensorContract[mtx,{{1,Length[leftidx1]+3},{2,Length[leftidx1]+Length[leftidx2]+4}}];*)
(*(* return the Tensor w/ everything the same except the TensorComponents and the indics \[Mu]1T and \[Mu]2T *)*)
(*Tensor[*)
(*xxx,*)
(*CoordinateSystem\[Rule]cooo,*)
(*StartIndex\[Rule]si,*)
(*Indices\[Rule]{i1,UnderBar/@\[Mu]1T,i2,UnderBar/@\[Mu]2T,i3},*)
(*TensorComponents\[Rule]mtx,*)
(*TooltipDisplay\[Rule]mtx*)
(*]*)
(*]/;((* check repeated indices *)\[Mu]1T\[LeftDoubleBracket]1\[RightDoubleBracket]===\[Mu]2T\[LeftDoubleBracket]1\[RightDoubleBracket])&&((* check one index up and one down *)Sgn[\[Mu]1T]Sgn[\[Mu]2T]===-1)&&(!((* check that both indices are abstract *)Intersection[{NumericIndex[\[Mu]1T,cooo,si]\[LeftDoubleBracket]1\[RightDoubleBracket]},Range[si,Length[cooo]+si-1]]==={NumericIndex[\[Mu]1T,cooo,si]\[LeftDoubleBracket]1\[RightDoubleBracket]}))&&(!((* check that both indices are abstract *)Intersection[{NumericIndex[\[Mu]2T,cooo,si]\[LeftDoubleBracket]1\[RightDoubleBracket]},Range[si,Length[cooo]+si-1]]==={NumericIndex[\[Mu]2T,cooo,si]\[LeftDoubleBracket]1\[RightDoubleBracket]}))&&CheckIndex[\[Mu]1T]&&CheckIndex[\[Mu]2T];*)
(*(* w/o Tooltipdisplay*)*)
(*Tensor/:Tensor[*)
(*xxx___/;Union[Flatten[Cases[{xxx},TooltipDisplay\[Rule]nnn_,\[Infinity]]]]==={},*)
(*CoordinateSystem\[Rule]cooo_List,*)
(*StartIndex\[Rule]si_Integer,*)
(*Indices\[Rule]{i1___,\[Mu]1T_,i2___,\[Mu]2T_,i3___},*)
(*TensorComponents\[Rule]matrix_*)
(*]:=Module[{mtx,MJ,ix1,ix2,leftidx1,leftidx2},*)
(*MJ=IdentityMatrix[Length[cooo]];*)
(*(* we are going to contract Tensor with Subscript[\[Delta]^\[Mu]1, \[Mu]2] or Subscript[\[Delta]^\[Mu]2, \[Mu]1] *)*)
(*mtx=TensorProduct[MJ,matrix];*)
(*(* ... do not include indices that do not pass CheckIndex ensuring that sequential Tensor reduction is OK as long as the UnderBar is applied to the said index after TensorContract is applied *)*)
(*leftidx1=DeleteCases[{i1},xx_/;CheckIndex[xx]===False];*)
(*leftidx2=DeleteCases[{i2},xx_/;CheckIndex[xx]===False];*)
(*mtx=TensorContract[mtx,{{1,Length[leftidx1]+3},{2,Length[leftidx1]+Length[leftidx2]+4}}];*)
(*(* return the Tensor w/ everything the same except the TensorComponents and the indics \[Mu]1T and \[Mu]2T *)*)
(*Tensor[*)
(*xxx,*)
(*CoordinateSystem\[Rule]cooo,*)
(*StartIndex\[Rule]si,*)
(*Indices\[Rule]{i1,UnderBar/@\[Mu]1T,i2,UnderBar/@\[Mu]2T,i3},*)
(*TensorComponents\[Rule]mtx*)
(*]*)
(*]/;((* check repeated indices *)\[Mu]1T\[LeftDoubleBracket]1\[RightDoubleBracket]===\[Mu]2T\[LeftDoubleBracket]1\[RightDoubleBracket])&&((* check one index up and one down *)Sgn[\[Mu]1T]Sgn[\[Mu]2T]===-1)&&(!((* check that both indices are abstract *)Intersection[{NumericIndex[\[Mu]1T,cooo,si]\[LeftDoubleBracket]1\[RightDoubleBracket]},Range[si,Length[cooo]+si-1]]==={NumericIndex[\[Mu]1T,cooo,si]\[LeftDoubleBracket]1\[RightDoubleBracket]}))&&(!((* check that both indices are abstract *)Intersection[{NumericIndex[\[Mu]2T,cooo,si]\[LeftDoubleBracket]1\[RightDoubleBracket]},Range[si,Length[cooo]+si-1]]==={NumericIndex[\[Mu]2T,cooo,si]\[LeftDoubleBracket]1\[RightDoubleBracket]}))&&CheckIndex[\[Mu]1T]&&CheckIndex[\[Mu]2T];*)
(**)*)


(* ::Input::Initialization:: *)
(* Appearance of Metric Tensor *)
(* Jan 2014: we have decided to display the metric as any other rank 2 tensor i.e. Subscript[g, \[Mu]\[Nu]] or g^\[Mu]\[Nu] or Subscript[\[Delta]^\[Mu], \[Nu]] (if TensorName is g). TensorComponents are displayed by hovering mouse cursor over Subscript[g, \[Mu]\[Nu]]. *)
(* Tensor/:Format[Tensor[
TensorType\[Rule]"Metric",
TensorName\[Rule]name_,
StartIndex\[Rule]si_Integer(*/;si\[GreaterEqual]0*),
Indices\[Rule]{\[Mu]T_/;CheckIndex[\[Mu]T],\[Nu]T_/;CheckIndex[\[Nu]T]},
CoordinateSystem\[Rule]coords_,
TensorComponents\[Rule]matrix_,
ChristoffelComponents\[Rule]ChrisRules_,
RiemannComponents\[Rule]RiemRules_,
RicciComponents\[Rule]RicRules_,
RicciScalarInvariant\[Rule]RRules_,
xx___
]]:=Tensor[
xx,
"Coordinates"\[Rule]coords,
Row[{name,UpOrDown[\[Mu]T],UpOrDown[\[Nu]T]}]\[Rule]matrix,
StartIndex\[Rule]si,
(ChrisRules/.{ChristoffelComponents[SuperMinus[\[Mu]s_],SubMinus[\[Alpha]s_],SubMinus[\[Beta]s_]]\[RuleDelayed]Row[{"\[CapitalGamma]",Column[{coords\[LeftDoubleBracket]\[Mu]s-si+1\[RightDoubleBracket],Null}],Column[{Null,coords\[LeftDoubleBracket]\[Alpha]s-si+1\[RightDoubleBracket]}],Column[{Null,coords\[LeftDoubleBracket]\[Beta]s-si+1\[RightDoubleBracket]}]}]}),
(RiemRules/.{RiemannComponents[SuperMinus[\[Mu]s_],SubMinus[\[Nu]s_],SubMinus[\[Alpha]s_],SubMinus[\[Beta]s_]]\[RuleDelayed]Row[{"R",Column[{coords\[LeftDoubleBracket]\[Mu]s-si+1\[RightDoubleBracket],Null}],Column[{Null,coords\[LeftDoubleBracket]\[Nu]s-si+1\[RightDoubleBracket]}],Column[{Null,coords\[LeftDoubleBracket]\[Alpha]s-si+1\[RightDoubleBracket]}],Column[{Null,coords\[LeftDoubleBracket]\[Beta]s-si+1\[RightDoubleBracket]}]}]}),
RicRules/.{RicciComponents[SubMinus[\[Nu]s_],SubMinus[\[Beta]s_]]\[RuleDelayed]Row[{"R",Column[{Null,coords\[LeftDoubleBracket]\[Nu]s-si+1\[RightDoubleBracket]}],Column[{Null,coords\[LeftDoubleBracket]\[Beta]s-si+1\[RightDoubleBracket]}]}]},
RRules/.{RicciScalar\[Rule]"R"}
]; *)


(* ::Input::Initialization:: *)
(* Format: *)
(* Appearance of non-Metric Tensor *)
(* we display the TensorName and associated indices *)
(* w/ TooltipDisplay *)
Tensor/:Format[Tensor[
xxx___,
(* TensorType\[Rule]type_/;(type=!="Metric")*)
TensorName->name_,
Indices->\[Mu]T_List(*/;(Union[(CheckIndex[#]&&MatchQ[#\[LeftDoubleBracket]1\[RightDoubleBracket],_Symbol])&/@\[Mu]T]==={True})*),
TooltipDisplay->display_/;(display=!=Null)
]]:=Tooltip[Row[{FormatTensorName[name],Sequence@@(UpOrDown[#]&/@\[Mu]T)}],Which[Head[display]===List,Flatten[display],True,display](*,LabelStyle\[Rule]{Large}*)](*/;(Cases[{name},Del[_],\[Infinity]]==={})*);
(* w/o TooltipDisplay I of II *)
(* Scalars, vectors and rank-2 tensors *)
Tensor/:Format[Tensor[
xxx___/;((Union[Flatten[Cases[{xxx},TooltipDisplay->mmm_,\[Infinity]]]]==={})||(Union[Flatten[Cases[{xxx},(TooltipDisplay->mmm_)->mmm,\[Infinity]]]]==={Null})),
(* TensorType\[Rule]type_/;(type=!="Metric")*)
TensorName->name_,
Indices->\[Mu]T_List(*/;(Union[(CheckIndex[#]&&MatchQ[#\[LeftDoubleBracket]1\[RightDoubleBracket],_Symbol])&/@\[Mu]T]==={True})*),
TensorComponents->ttM_,
CoordinateSystem->coords_List
]/;((* scalar, vector or rank 2 tensor *)(RemoveUnderBarredIndices[\[Mu]T]==={})||MatchQ[Dimensions[ttM],{Length[coords]}|{Length[coords],Length[coords]}])]:=Tooltip[Row[{FormatTensorName[name],Sequence@@(UpOrDown[#]&/@\[Mu]T)}],
{MatrixForm[ttM],"Coordinates"->coords}];
(* w/o TooltipDisplay II of II *)
(* everything else *)
 Tensor/:Format[Tensor[
xxx___/;((Union[Flatten[Cases[{xxx},TooltipDisplay->mmm_,\[Infinity]]]]==={})||(Union[Flatten[Cases[{xxx},(TooltipDisplay->mmm_)->mmm,\[Infinity]]]]==={Null})),
(* TensorType\[Rule]type_/;(type=!="Metric")*)
TensorName->name_,
Indices->\[Mu]T_List(*/;(Union[(CheckIndex[#]&&MatchQ[#\[LeftDoubleBracket]1\[RightDoubleBracket],_Symbol])&/@\[Mu]T]==={True})*),
TensorComponents->ttM_,
CoordinateSystem->coords_List
]/;!((* scalar, vector or rank 2 tensor *)(RemoveUnderBarredIndices[\[Mu]T]==={})||MatchQ[Dimensions[ttM],{Length[coords]}|{Length[coords],Length[coords]}])]:=Row[{FormatTensorName[name],Sequence@@(UpOrDown[#]&/@\[Mu]T)}];


(* ::Input::Initialization:: *)
(* Format: Appearance of non-Metric Tensor w/ Del[...Del[stuff w/o Del's]]: to do! *)
(* we display the TensorName and associated indices *)
(* w/ TooltipDisplay *)
(* Tensor/:Format[Tensor[
xxx___,
TensorType\[Rule]type_/;type=!="Metric",
TensorName\[Rule]name_,
Indices\[Rule]\[Mu]T_List(*/;(Union[(CheckIndex[#]&&MatchQ[#\[LeftDoubleBracket]1\[RightDoubleBracket],_Symbol])&/@\[Mu]T]==={True})*),
TooltipDisplay\[Rule]display_
]]:=Module[{stuff,output,idx},
Tooltip[Row[{name,Sequence@@(UpOrDown[#]&/@\[Mu]T)}],Which[Head[display]===List,Flatten[display],True,display](*,LabelStyle\[Rule]{Large}*)]
]/;((Head[name]===Del));
(* w/o TooltipDisplay *)
Tensor/:Format[Tensor[
xxx___/;(Union[Flatten[Cases[{xxx},TooltipDisplay\[Rule]mmm_,\[Infinity]]]]==={}),
TensorType\[Rule]type_/;type=!="Metric",
TensorName\[Rule]name_,
Indices\[Rule]\[Mu]T_List(*/;(Union[(CheckIndex[#]&&MatchQ[#\[LeftDoubleBracket]1\[RightDoubleBracket],_Symbol])&/@\[Mu]T]==={True})*)
]]:=Row[{name,Sequence@@(UpOrDown[#]&/@\[Mu]T)}]/;((Head[name]===Del)); *)
(* TensorProduct of Tensors *)
(* It is not possible to do something like Tensor/:TensorProduct[Times[t1___,mm_,t2___]]/;Head[mm]=!=Tensor:=... *)
(* So we create ContractTensors below *)


(* ::Input::Initialization:: *)
(* TensorSymmetry of Tensors *)
Tensor/:TensorSymmetry[Tensor[stuff___]]:=TensorSymmetry[TensorComponents[Tensor[stuff]]];


(* ::Input::Initialization:: *)
(* Dimensions of Tensors *)
Tensor/:Dimensions[Tensor[stuff___]]:=Dimensions[TensorComponents[Tensor[stuff]]];


(* ::Subsubsection::Closed:: *)
(*Tensor arguments (Reference only, no code)*)


(* ::Text::Initialization:: *)
(*The most general Tensor object contains the following arguments*)
(**)
(*Tensor[*)
(*	TensorType -> _,*)
(*	TensorName -> _,*)
(*	Indices ->{__},*)
(*	TooltipDisplay ->_,*)
(*	StartIndex->si_Integer,*)
(*	CoordinateSystem->{coords__},*)
(*	TensorComponents->matrix_,*)
(*	ChristoffelComponents->ChrisRules_,*)
(*	MetricDeterminant->Detg_,*)
(*	RiemannComponents->RiemRules_,*)
(*	RicciComponents->RicRules_,*)
(*	RicciScalarInvariant->RRules_*)
(*]*)


(* ::Subsection::Closed:: *)
(*Metric*)


(* ::Input::Initialization:: *)
(* Entering a geometry *)
(* I of II: Metric takes in a specific metric and CoordinateSystem, computes Christoffel symbols,Riemann, Ricci tensor and scalar,and returns a Tensor containing these computations. *)
Metric[\[Mu]T_/;CheckIndex[\[Mu]T],\[Nu]T_/;CheckIndex[\[Nu]T],matrix_/;(MatchQ[Dimensions[matrix],{nn_,nn_}]&&(Head[matrix]===List)),opts:OptionsPattern[]]/;(MatchQ[{\[Mu]T,\[Nu]T},{SubMinus[_],SubMinus[_]}]||MatchQ[{\[Mu]T,\[Nu]T},{SuperMinus[_],SuperMinus[_]}]):=Tensor[
TensorType->"Metric",
CoordinateSystem->OptionValue[CoordinateSystem],
TensorName->OptionValue[TensorName],
StartIndex->OptionValue[StartIndex],
ChristoffelOperator->OptionValue[ChristoffelOperator],
RiemannOperator->OptionValue[RiemannOperator],
RicciOperator->OptionValue[RicciOperator],
RicciScalarOperator->OptionValue[RicciScalarOperator],
Indices->{\[Mu]T,\[Nu]T},
TensorComponents->matrix
]/;((Head[OptionValue[StartIndex]]===Integer)&&(OptionValue[StartIndex]>=0));
(* II of II: Same as above, except we allow the metric to be entered in terms of differentials \[DifferentialD]t, \[DifferentialD]x, etc. *)
(* For now we only allow for lower indices; we need to find a way to let the user enter \!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]s\) *)
Metric[\[Mu]T_/;CheckIndex[\[Mu]T],\[Nu]T_/;CheckIndex[\[Nu]T],matrix_,opts:OptionsPattern[]]/;(MatchQ[{\[Mu]T,\[Nu]T},{SubMinus[_],SubMinus[_]}]):=Module[
{MetricM,\[Mu],\[Nu],dcoords,lgth},
(* convert the expression matrix to a dim. x dim. List matrix *)
lgth=Length[OptionValue[CoordinateSystem]];
dcoords=(\[DifferentialD]#)&/@OptionValue[CoordinateSystem];
MetricM=Table[
Which[
	(* off diagonal terms *)
	\[Mu]=!=\[Nu],1/2 Coefficient[Expand[matrix],dcoords[[\[Mu]]]dcoords[[\[Nu]]]],
	(* diagonal terms *)
	\[Mu]===\[Nu],Coefficient[Expand[matrix],dcoords[[\[Mu]]]dcoords[[\[Nu]]]]
],
{\[Mu],1,lgth},{\[Nu],1,lgth}];
(* then feed matrix into the same code as above *)
Tensor[
TensorType->"Metric",
CoordinateSystem->OptionValue[CoordinateSystem],
TensorName->OptionValue[TensorName],
StartIndex->OptionValue[StartIndex],
ChristoffelOperator->OptionValue[ChristoffelOperator],
RiemannOperator->OptionValue[RiemannOperator],
RicciOperator->OptionValue[RicciOperator],
RicciScalarOperator->OptionValue[RicciScalarOperator],
Indices->{\[Mu]T,\[Nu]T},
TensorComponents->MetricM
]
]/;((Head[OptionValue[StartIndex]]===Integer)&&(OptionValue[StartIndex]>=0)&&CheckMetric[matrix,OptionValue[CoordinateSystem]]);
(* Metric also takes in a Tensor object of type Metric and spits out the components *)
(* aka Raising and lowering of Metric indices *)
(* one up and one down *)
Metric[\[Mu]T_/;CheckIndex[\[Mu]T],\[Nu]T_/;CheckIndex[\[Nu]T],m_Tensor]/;((MatchQ[{\[Mu]T,\[Nu]T},{SuperMinus[_],SubMinus[_]}]||MatchQ[{\[Mu]T,\[Nu]T},{SubMinus[_],SuperMinus[_]}])&&(Cases[m,(TensorType->tt_)->tt]==={"Metric"})):=Module[{idx,cpts,row,col,l,ix,mx,id},
l=Length[Cases[m,(CoordinateSystem->mmm_)->mmm][[1]]];
ix=Cases[m,(Indices->idx_)->idx][[1]];
mx=Cases[m,(TensorComponents->cpts_)->cpts][[1]];
id=Table[KroneckerDelta[row,col],{row,1,l},{col,1,l}];
m/.{
(Indices->ix)->(Indices->{\[Mu]T,\[Nu]T}),
(TensorComponents->mx)->(TensorComponents->id)
}
];
(* both lower *)
Metric[\[Mu]T_/;CheckIndex[\[Mu]T],\[Nu]T_/;CheckIndex[\[Nu]T],m_Tensor]/;(MatchQ[{\[Mu]T,\[Nu]T},{SubMinus[_],SubMinus[_]}]&&(Cases[m,(TensorType->tt_)->tt]==={"Metric"})):=Module[{ix,mx},
ix=Cases[m,(Indices->idx_)->idx][[1]];
mx=Cases[m,(TensorComponents->idx_)->idx][[1]];
Which[
(* both lower then just return the Tensor *)
MatchQ[ix,{SubMinus[_],SubMinus[_]}],
m/.(Indices->ix)->(Indices->{\[Mu]T,\[Nu]T}),
(* both upper we have to invert the TensorComponents *)
MatchQ[ix,{SuperMinus[_],SuperMinus[_]}],
m/.{
(Indices->ix)->(Indices->{\[Mu]T,\[Nu]T}),
(TensorComponents->mx):>(TensorComponents->FullSimplify[Inverse[mx]])}
]
];
(* both upper *)
Metric[\[Mu]T_/;CheckIndex[\[Mu]T],\[Nu]T_/;CheckIndex[\[Nu]T],m_Tensor]/;(MatchQ[{\[Mu]T,\[Nu]T},{SuperMinus[_],SuperMinus[_]}]&&(Cases[m,(TensorType->tt_)->tt]==={"Metric"})):=Module[{ix,mx},
ix=Cases[m,(Indices->idx_)->idx][[1]];
mx=Cases[m,(TensorComponents->idx_)->idx][[1]];
Which[
(* both upper then just return the Tensor *)
MatchQ[ix,{SuperMinus[_],SuperMinus[_]}],
m/.(Indices->ix)->(Indices->{\[Mu]T,\[Nu]T}),
(* both lower we have to invert the TensorComponents *)
MatchQ[ix,{SubMinus[_],SubMinus[_]}],
m/.{
(Indices->ix)->(Indices->{\[Mu]T,\[Nu]T}),
(TensorComponents->mx):>(TensorComponents->FullSimplify[Inverse[mx]])}
]
];


(* ::Subsection::Closed:: *)
(*NonMetricTensor*)


(* ::Input::Initialization:: *)
(* Generates a Tensor with components stuff and indices \[Mu]T *)
NonMetricTensor[\[Mu]T_List,stuff_List,exp_,CoordinateSystem->coords_List,opts:OptionsPattern[]]/;(Union[CheckIndex/@\[Mu]T]==={True})&&MatchQ[Dimensions[stuff],{nnn_Integer..}]:=Tensor[
Indices->\[Mu]T,
CoordinateSystem->coords,
TensorComponents->stuff,
TensorName->exp,
StartIndex->OptionValue[StartIndex],
TooltipDisplay->OptionValue[TooltipDisplay],TensorType->OptionValue[TensorType]
];


(* ::Subsection::Closed:: *)
(*Christoffel*)


(* ::Input::Initialization:: *)
(* either input the coordinates or their corresponding numbers *)
(* Internally we build the Tensor with abstract indices before evaluating it with the specified ones *)
Christoffel[\[Mu]I_/;CheckIndex[\[Mu]I],\[Alpha]I_/;CheckIndex[\[Alpha]I],\[Beta]I_/;CheckIndex[\[Beta]I],m_Tensor]/;((Cases[m,(TensorType->tt_)->tt]==={"Metric"})&&MatchQ[\[Mu]I,SuperMinus[_]]&&MatchQ[\[Alpha]I,SubMinus[_]]&&MatchQ[\[Beta]I,SubMinus[_]]):=Module[
{\[Mu],\[Alpha],\[Beta],cooo,st,d,mm,Chris,cc,disp},
cooo=Flatten[Cases[m,(CoordinateSystem->cc_)->cc,Infinity]];
d=Length[cooo];
st=Flatten[Cases[m,(StartIndex->cc_)->cc,Infinity]][[1]];
Chris=Flatten[Cases[m,(ChristoffelComponents->cc_)->cc,Infinity]];
mm=Table[(ChristoffelComponents[SuperMinus[\[Mu]],SubMinus[\[Alpha]],SubMinus[\[Beta]]]/.Chris),{\[Mu],st,st+d-1},{\[Alpha],st,st+d-1},{\[Beta],st,st+d-1}];
(* display only non-zero components *)
disp=Select[Chris,(Flatten[Cases[{#},(ChristoffelComponents[__]->cc_)->cc]][[1]]=!=0)&];
disp=(disp/.{ChristoffelComponents[SuperMinus[\[Mu]s_],SubMinus[\[Alpha]s_],SubMinus[\[Beta]s_]]:>Row[{"\[CapitalGamma]",Column[{cooo[[\[Mu]s-st+1]],Null}],Column[{Null,cooo[[\[Alpha]s-st+1]]}],Column[{Null,cooo[[\[Beta]s-st+1]]}]}]});
Tensor[
TensorType->"ChristoffelSymbols",
TensorName->"\[CapitalGamma]",
CoordinateSystem->cooo,
TensorComponents->mm,
StartIndex->st,
Indices->{\[Mu]I,\[Alpha]I,\[Beta]I},
TooltipDisplay->disp
]
];


(* ::Subsection::Closed:: *)
(*Riemann*)


(* ::Input::Initialization:: *)
(* either input the coordinates or their corresponding numbers *)
(* Internally we build the Tensor with abstract indices before evaluating it with the specified ones *)
Riemann[\[Mu]I_/;CheckIndex[\[Mu]I],\[Nu]I_/;CheckIndex[\[Nu]I],\[Alpha]I_/;CheckIndex[\[Alpha]I],\[Beta]I_/;CheckIndex[\[Beta]I],m_Tensor]/;(Cases[m,(TensorType->tt_)->tt]==={"Metric"}):=Module[
{mm,\[Mu],\[Nu],\[Alpha],\[Beta],\[Mu]1,\[Nu]1,\[Alpha]1,\[Beta]1,rl,si,cooo,disp,d,cc,Rie,lhs,rhs,RL1,RL2,RL3,RL4,RiemannTemp,\[Tau]},
cooo=Flatten[Cases[m,(CoordinateSystem->cc_)->cc]];
d=Length[cooo];
si=Cases[m,(StartIndex->cc_)->cc][[1]];
Rie=Flatten[Cases[m,(RiemannComponents->cc_)->cc,Infinity]];
Do[RL1[\[Mu],\[Mu]1]=RaiseLower[ReplaceIndex[\[Mu],\[Mu]I],SuperMinus[\[Mu]1],m],{\[Mu],si,si+d-1},{\[Mu]1,si,si+d-1}];
Do[RL2[\[Nu],\[Nu]1]=RaiseLower[ReplaceIndex[\[Nu],\[Nu]I],SubMinus[\[Nu]1],m],{\[Nu],si,si+d-1},{\[Nu]1,si,si+d-1}];
Do[RL3[\[Alpha],\[Alpha]1]=RaiseLower[ReplaceIndex[\[Alpha],\[Alpha]I],SubMinus[\[Alpha]1],m],{\[Alpha],si,si+d-1},{\[Alpha]1,si,si+d-1}];
Do[RL4[\[Beta],\[Beta]1]=RaiseLower[ReplaceIndex[\[Beta],\[Beta]I],SubMinus[\[Beta]1],m],{\[Beta],si,si+d-1},{\[Beta]1,si,si+d-1}];
Do[RiemannTemp[\[Mu]1,\[Nu]1,\[Alpha]1,\[Beta]1]=(RiemannComponents[SuperMinus[\[Mu]1],SubMinus[\[Nu]1],SubMinus[\[Alpha]1],SubMinus[\[Beta]1]]/.Rie),
{\[Mu]1,si,si+d-1},{\[Nu]1,si,si+d-1},{\[Alpha]1,si,si+d-1},{\[Beta]1,si,si+d-1}];
mm=Table[Sum[RL1[\[Mu],\[Mu]1]RL2[\[Nu],\[Nu]1]RL3[\[Alpha],\[Alpha]1]RL4[\[Beta],\[Beta]1]RiemannTemp[\[Mu]1,\[Nu]1,\[Alpha]1,\[Beta]1],
{\[Mu]1,si,si+d-1},{\[Nu]1,si,si+d-1},{\[Alpha]1,si,si+d-1},{\[Beta]1,si,si+d-1}],
{\[Mu],si,si+d-1},{\[Nu],si,si+d-1},{\[Alpha],si,si+d-1},{\[Beta],si,si+d-1}];
(* Originally we wanted to display Riemann components *)
(* But there are so many components and it slows the whole process down too much *)
(* So we are going to skip this for now *)
(*
disp=Flatten[Table[{Row[{"R",UpOrDown[ReplaceIndex[cooo\[LeftDoubleBracket]\[Mu]\[RightDoubleBracket],\[Mu]I]],UpOrDown[ReplaceIndex[cooo\[LeftDoubleBracket]\[Nu]\[RightDoubleBracket],\[Nu]I]],UpOrDown[ReplaceIndex[cooo\[LeftDoubleBracket]\[Alpha]\[RightDoubleBracket],\[Alpha]I]],UpOrDown[ReplaceIndex[cooo\[LeftDoubleBracket]\[Beta]\[RightDoubleBracket],\[Beta]I]]}]\[Rule]mm\[LeftDoubleBracket]\[Mu],\[Nu],\[Alpha],\[Beta]\[RightDoubleBracket]},
{\[Mu],1,d},{\[Nu],1,d},{\[Alpha],1,d},{\[Beta],1,d}]];
disp=Select[disp,(Flatten[Cases[{#},(Row[{__}]\[Rule]cc_)\[Rule]cc]]\[LeftDoubleBracket]1\[RightDoubleBracket]=!=0)&];
*)
Tensor[
TensorType->"RiemannCurvatureTensor",
TensorName->"\!\(\*
StyleBox[\"R\",\nFontSlant->\"Italic\"]\)",
CoordinateSystem->Flatten[Cases[m,(CoordinateSystem->cc_)->cc]],
TensorComponents->mm,
StartIndex->si,
Indices->{\[Mu]I,\[Nu]I,\[Alpha]I,\[Beta]I}(*,
TooltipDisplay\[Rule]"Tidal forces encoded here. \[HappySmiley]"*)
]
];


(* ::Subsection::Closed:: *)
(*Ricci*)


(* ::Input::Initialization:: *)
(* either input the coordinates or their corresponding numbers *)
Ricci[\[Nu]I_/;CheckIndex[\[Nu]I],\[Beta]I_/;CheckIndex[\[Beta]I],m_Tensor]/;(Cases[m,(TensorType->tt_)->tt]==={"Metric"}):=Module[
{mm,\[Mu],\[Nu],\[Alpha],\[Beta],\[Mu]1,\[Nu]1,\[Alpha]1,\[Beta]1,rl,si,cooo,disp,d,cc,Ric,RL1,RL2,RicciTemp},
cooo=Flatten[Cases[m,(CoordinateSystem->cc_)->cc]];
d=Length[cooo];
si=Cases[m,(StartIndex->cc_)->cc][[1]];
Ric=Flatten[Cases[m,(RicciComponents->cc_)->cc,Infinity]];
Do[RL1[\[Nu],\[Nu]1]=RaiseLower[ReplaceIndex[\[Nu],\[Nu]I],SubMinus[\[Nu]1],m],{\[Nu],si,si+d-1},{\[Nu]1,si,si+d-1}];
Do[RL2[\[Beta],\[Beta]1]=RaiseLower[ReplaceIndex[\[Beta],\[Beta]I],SubMinus[\[Beta]1],m],{\[Beta],si,si+d-1},{\[Beta]1,si,si+d-1}];
Do[RicciTemp[\[Nu]1,\[Beta]1]=(RicciComponents[SubMinus[\[Nu]1],SubMinus[\[Beta]1]]/.Ric),
{\[Nu]1,si,si+d-1},{\[Beta]1,si,si+d-1}];
mm=Table[
Sum[RL1[\[Nu],\[Nu]1]RL2[\[Beta],\[Beta]1]RicciTemp[\[Nu]1,\[Beta]1],{\[Nu]1,si,si+d-1},{\[Beta]1,si,si+d-1}],
{\[Nu],si,si+d-1},{\[Beta],si,si+d-1}];
disp={Row[{"\!\(\*
StyleBox[\"R\",\nFontSlant->\"Italic\"]\)",UpOrDown[\[Nu]I],UpOrDown[\[Beta]I]}]->mm,"Coordinates"->cooo};
Tensor[
TensorType->"RicciCurvatureTensor",
TensorName->"\!\(\*
StyleBox[\"R\",\nFontSlant->\"Italic\"]\)",
CoordinateSystem->Flatten[Cases[m,(CoordinateSystem->cc_)->cc]],
TensorComponents->mm,
StartIndex->si,
Indices->{\[Nu]I,\[Beta]I},
TooltipDisplay->disp
]
];


(* ::Subsection::Closed:: *)
(*RicciScalar*)


(* ::Input::Initialization:: *)
RicciScalar[m_Tensor]/;(Cases[m,(TensorType->tt_)->tt]==={"Metric"}):=(RicciScalar/.Flatten[Cases[m,(RicciScalarInvariant->cc_)->cc]]);


(* ::Subsection::Closed:: *)
(*Weyl*)


(* ::Input::Initialization:: *)
(* either input the coordinates or their corresponding numbers *)
(* Internally we build the Tensor with abstract indices before evaluating it with the specified ones *)
(* d>3 *)
Weyl[\[Alpha]I_/;CheckIndex[\[Alpha]I],\[Beta]I_/;CheckIndex[\[Beta]I],\[Mu]I_/;CheckIndex[\[Mu]I],\[Nu]I_/;CheckIndex[\[Nu]I],m_Tensor,opts:OptionsPattern[]]/;(Cases[m,(TensorType->tt_)->tt]==={"Metric"})&&((* check d>3 *)Union[Dimensions[m]][[1]]>3):=Module[
{mm,W,W0,\[Mu],\[Nu],\[Alpha],\[Beta],si,cooo,d,op},
op=OptionValue[WeylOperator];
cooo=Flatten[Cases[m,(CoordinateSystem->cc_)->cc]];
d=Length[cooo];
si=Cases[m,(StartIndex->cc_)->cc][[1]];
W[\[Alpha]_,\[Beta]_,\[Mu]_,\[Nu]_,mm_Tensor]:=Riemann[\[Alpha],\[Beta],\[Mu],\[Nu],mm]-1/(d-2) ((Ricci[\[Alpha],\[Mu],mm]Metric[\[Nu],\[Beta],mm]-Ricci[\[Alpha],\[Nu],mm]Metric[\[Mu],\[Beta],mm])-(Ricci[\[Beta],\[Mu],mm]Metric[\[Nu],\[Alpha],mm]-Ricci[\[Beta],\[Nu],mm]Metric[\[Mu],\[Alpha],mm]))+RicciScalar[mm]/((d-1)(d-2)) (Metric[\[Alpha],\[Mu],mm]Metric[\[Nu],\[Beta],mm]-Metric[\[Alpha],\[Nu],mm]Metric[\[Mu],\[Beta],mm]);
W0=W[ReplaceIndex[\[Alpha],\[Alpha]I],ReplaceIndex[\[Beta],\[Beta]I],ReplaceIndex[\[Mu],\[Mu]I],ReplaceIndex[\[Nu],\[Nu]I],m];
W0=Table[op[W0],{\[Alpha],si,si+d-1},{\[Beta],si,si+d-1},{\[Mu],si,si+d-1},{\[Nu],si,si+d-1}];
Tensor[
TensorType->"WeylCurvatureTensor",
TensorName->"\!\(\*
StyleBox[\"C\",\nFontSlant->\"Italic\"]\)",
CoordinateSystem->cooo,
TensorComponents->W0,
StartIndex->si,
Indices->{\[Alpha]I,\[Beta]I,\[Mu]I,\[Nu]I}(*,
TooltipDisplay\[Rule]"Weyl is the traceless part of the Riemann tensor."*)
]
];


(* ::Input::Initialization:: *)
(* d<=3 *)
(* Weyl, defined to be the traceless part of Riemann is zero if d =2 or d = 3. *)
(* For 3D we have done a brute force calculation to prove it. *)
(* For 2D the usual formula for Weyl breaks down; Use fact that einstein tensor is zero and 2D metrics are conformally flat to prove *)
(* Riemann has only 1 independent component in 2D so heuristically that means subtracting its trace should yield zero *)
Weyl[\[Alpha]I_/;CheckIndex[\[Alpha]I],\[Beta]I_/;CheckIndex[\[Beta]I],\[Mu]I_/;CheckIndex[\[Mu]I],\[Nu]I_/;CheckIndex[\[Nu]I],m_Tensor,opts:OptionsPattern[]]/;(Cases[m,(TensorType->tt_)->tt]==={"Metric"})&&((* check d<=3 *)Union[Dimensions[m]][[1]]<=3):=Module[
{mm,W,W0,\[Mu],\[Nu],\[Alpha],\[Beta],si,cooo,d,op},
cooo=Flatten[Cases[m,(CoordinateSystem->cc_)->cc]];
d=Length[cooo];
si=Cases[m,(StartIndex->cc_)->cc][[1]];
(* generate an array of zeroes *)
W0=ConstantArray[0,{d,d,d,d}];
Tensor[
TensorType->"WeylCurvatureTensor",
TensorName->"C",
CoordinateSystem->cooo,
TensorComponents->W0,
StartIndex->si,
Indices->{\[Alpha]I,\[Beta]I,\[Mu]I,\[Nu]I},
TooltipDisplay->"Weyl, being the traceless part of the Riemann tensor, is zero in 2D and 3D."
]
];


(* ::Subsection::Closed:: *)
(*Einstein*)


(* ::Input::Initialization:: *)
(* Einstein Tensor *)
(* either input the coordinates or their corresponding numbers *)
Einstein[\[Nu]I_/;CheckIndex[\[Nu]I],\[Beta]I_/;CheckIndex[\[Beta]I],m_Tensor,opts:OptionsPattern[]]/;(Cases[m,(TensorType->tt_)->tt]==={"Metric"}):=Module[
{mm,cooo,si,disp,RicciScalarT,RicciTensorT,MetricT,op,\[Nu]T,\[Beta]T},
op=OptionValue[EinsteinOperator];
RicciScalarT=RicciScalar[m];
(* we will construct Einstein with abstract indices first... *)
RicciTensorT=TensorComponents[Ricci[ReplaceIndex[\[Nu]T,\[Nu]I],ReplaceIndex[\[Beta]T,\[Beta]I],m]];
MetricT=TensorComponents[Metric[ReplaceIndex[\[Nu]T,\[Nu]I],ReplaceIndex[\[Beta]T,\[Beta]I],m]];
mm=RicciTensorT-(MetricT/2)RicciScalarT;mm=op[mm];
si=Cases[m,(StartIndex->cc_)->cc][[1]];
cooo=Coordinates[m];
disp={Row[{"\!\(\*
StyleBox[\"G\",\nFontSlant->\"Italic\"]\)",UpOrDown[\[Nu]I],UpOrDown[\[Beta]I]}]->mm,"Coordinates"->cooo};
(* ...then we will evaluate it with specified indices which may be non-abstract *)
Tensor[
TensorType->"EinsteinTensor",
TensorName->"\!\(\*
StyleBox[\"G\",\nFontSlant->\"Italic\"]\)",
CoordinateSystem->cooo,
TensorComponents->mm,
StartIndex->si,
Indices->{\[Nu]I,\[Beta]I},
TooltipDisplay->disp
]
];


(* ::Subsection::Closed:: *)
(*Determinant*)


(* ::Input::Initialization:: *)
Determinant[m_Tensor]/;(Cases[m,(TensorType->tt_)->tt]==={"Metric"}):=Cases[m,(MetricDeterminant->mmm_)->mmm][[1]]


(* ::Subsection::Closed:: *)
(*Coordinates*)


(* ::Input::Initialization:: *)
Coordinates[m_Tensor]:=Module[{mmm},Cases[m,(CoordinateSystem->mmm_)->mmm,\[Infinity]][[1]]]


(* ::Subsection::Closed:: *)
(*ContractTensors*)


(* ::Input::Initialization:: *)
(* The main function for ContractTensors to act as a TensorProduct of sorts for Tensor objects *)
(* Note: Assigning upvalues for Tensor involving TensorProduct yields levels too deep for MMA to handle;
that's why we need ContractTensors *)
(* one Tensor *)
ContractTensors/:ContractTensors[tt_Tensor]:=tt;
(* Thread over Plus automatically *)
ContractTensors/:ContractTensors[mm_]:=(ContractTensors/@mm)/;(Head[mm]===Plus); 
(* Pull out non-Tensor objects *)
ContractTensors/:ContractTensors[mm_]:=Module[{allTensors,therest},
allTensors=Times@@Cases[(List@@mm),_Tensor];
therest=Times@@DeleteCases[(List@@mm),_Tensor];
therest ContractTensors[allTensors]]/;(Head[mm]===Times)&&(Union[(Head/@(List@@mm))]=!={Tensor});
ContractTensors/:ContractTensors[1]:=1;
(* Tensor product of more than one Tensors with same CoordinateSystem *)
ContractTensors/:ContractTensors[tt_]:=Block[
{tensorproduct,allindices,tensornames},
(* perform a tensor product *)
tensorproduct=TensorProduct[Sequence@@(TensorComponents/@(List@@tt))];
(* Join all indices to form index structure of Tensor Product *)
allindices=Join[Sequence@@(Indices/@(List@@tt))];
(* Tensor all the names *)
tensornames=TensorProduct[Sequence@@(Cases[#,(TensorName->name_):>name,\[Infinity]][[1]]&/@(List@@tt))];
(* output Tensor will inherit properties of the first Tensor *)
(List@@tt)[[1]]/.{
(TensorName->xxx_)->(TensorName->tensornames),
(Indices->xxx_)->(Indices->allindices),
(TensorComponents->xxxxx_)->(TensorComponents->tensorproduct)}
]/;((* check tensor product *)(Head[tt]===Times)&&(Length[tt]>1)&&(Union[Head/@(List@@tt)]==={Tensor})&&(Length[Union[Coordinates/@(List@@tt)]]===1)(*&&((* no Metrics *)Intersection[Union[Cases[{tt},(TensorType\[Rule]xx_)\[Rule]xx,\[Infinity]]],{"Metric"}]==={})*));


(* ::Input::Initialization:: *)
(* Take the product of two or more tensors and sum over repeated indices *)
(* contraction between 2g's, g non-g, or both non-g's *)
(* (I) contract of 2 g's *)
(* ContractTensors[Times[t1___,m1_,t2___,m2_,t3___]]:=; *)
(* Right now we do not check Dimensions are the same before we do ContractTensors *)
(* old code
ContractTensors[Times[tt__]]/;Union[Head/@(List@@Times[tt])]==={Tensor}:=Block[
{tensorproduct,allindices,repeatedindices,ix},
(* first perform a tensor product *)
tensorproduct=TensorProduct[Sequence@@(TensorComponents/@(List@@Times[tt]))];
(* extract repeated indices *)
ix=Indices/@(List@@Times[tt]);
repeatedindices=CollectRepeatedIndices[Sequence@@ix];
(* sum over repeated indices using TensorContract *)
(* list of all indices w/ Sub/SuperMinus removed from repeated ones *)
allindices=(Join[Sequence@@ix]/.Flatten[{(SuperMinus[#]\[Rule]#),(SubMinus[#]\[Rule]#)}&/@repeatedindices]);
tensorproduct=TensorContract[
tensorproduct,
(* {{pair 1},{pair 2},...} *)
Flatten[Position[allindices,#]]&/@repeatedindices
];
(* remove repeated indices *)
allindices=DeleteCases[allindices,Alternatives@@repeatedindices];
(* return Tensor *)
(* output Tensor will inherit properties of the first Tensor *)
(* output Tensor indices are inherited from tt, from left to right, with repeated indices discarded *)
(List@@Times[tt])\[LeftDoubleBracket]1\[RightDoubleBracket]/.{
(Indices\[Rule]xxx_)\[Rule](Indices\[Rule]allindices),
(TensorComponents\[Rule]xxxxx_)\[Rule](TensorComponents\[Rule]tensorproduct)
}
]; *)


(* ::Subsection::Closed:: *)
(*TensorComponents*)


(* ::Input::Initialization:: *)
(* One Tensor *)
TensorComponents[m_Tensor]:=Cases[m,(TensorComponents->mmm_):>mmm,\[Infinity]][[1]];
(* If there are no Tensor's then just return the same object *)
TensorComponents[m_]:=m/;(Union[Cases[{m},Tensor[stuff___],\[Infinity]]]==={});
(* Thread over Plus automatically *)
TensorComponents/:TensorComponents[mm_]:=(TensorComponents/@mm)/;(Head[mm]===Plus);
(* Use ContractTensors to take care of TensorProduct's *)
TensorComponents/:TensorComponents[mm_]:=Module[{allTensors,therest},
allTensors=Times@@Cases[(List@@mm),_Tensor];
therest=Times@@DeleteCases[(List@@mm),_Tensor];
therest TensorComponents[ContractTensors[allTensors]]
]/;(Head[mm]===Times);


(* ::Subsection::Closed:: *)
(*Indices*)


(* ::Input::Initialization:: *)
Indices[m_Tensor]:=Cases[m,(Indices->mmm_)->mmm,\[Infinity]][[1]]


(* ::Subsection::Closed:: *)
(*SwapIndices*)


(* ::Input::Initialization:: *)
(* SwapIndices returns tt except the indices are permuted into idx; i.e. Indices[tt] \[Rule] idx *)
(* idx does not include the UnderBarred indices in tt *)
SwapIndices[tt_Tensor,idx_List]/;((Sort[RemoveUnderBarredIndices[Indices[tt]]]===Sort[idx])&&(Union[(CheckIndex[#/.UnderBar[ss_]->ss]&/@idx)]==={True})):=tt/.{
(* replace TensorComponents *)
(TensorComponents->ss_):>(TensorComponents->Transpose[
TensorComponents[tt],Flatten[Position[(* this is the ordering of indices we want *)idx,#]&/@RemoveUnderBarredIndices[Indices[tt]]]]),
(* replace Indices but remember not to throw away the UnderBarred Indices *)
(Indices->ss_):>(Indices->(ss/.Thread[Rule[RemoveUnderBarredIndices[Indices[tt]],idx]]))
};


(* ::Subsection::Closed:: *)
(*MoveIndices*)


(* ::Input::Initialization:: *)
(* MoveIndices[tt_Tensor,idx_List,m_Tensor] returns tt with its indices moved/replaced to idx *)
(* idx does not include the UnderBarred indices in tt but has to contain the same number of indices *)
(* idx may also contain coordinates; i.e., MoveIndices should be able to do evaluate specific components of the tensor *)
(* new code *)
MoveIndices[tt_Tensor,idx_List,m_Tensor]/;((* check that there are same number of indices in tt and idx *)(Length[RemoveUnderBarredIndices[Indices[tt]]]===Length[idx])&&((* check idx contain proper indices *)Union[(CheckIndex/@idx)]==={True})&&((* check m is a Metric; we are going use it to move the indices with *)CheckMetricTensor[m])):=Module[
{outputindices,ttix,outputtensor,s,g,Invg,xxx123,i123,\[Mu],\[Nu]},
(* extract relevant indices of tt *)
ttix=RemoveUnderBarredIndices[Indices[tt]];
(* we will replace the indices of tt with idx *)
outputindices=Thread[Rule[ttix,idx]];
(* start with *)
outputtensor=TensorComponents[tt];
(* first compute metric and inverse and extract TensorComponents of tt *)
g=TensorComponents[Metric[SubMinus[\[Mu]],SubMinus[\[Nu]],m]];
Invg=TensorComponents[Metric[SuperMinus[\[Mu]],SuperMinus[\[Nu]],m]];
(* we will run through all relevant indices of tt *)
(* compare each slot with the corresponding one in idx *)
Do[
Which[
(* different sgn; append appropriate g or Inv *)
(* raise index; contract Subscript[T, i1 i2 ... j ... iD] g^(j is); then transpose to get the right ordering of indices *)
(* last index does not need to be further transposed! *)
(Sgn[ttix[[s]]]===-1)&&(Sgn[idx[[s]]]===1),
outputtensor=Which[
s<Length[idx],Transpose[TensorContract[TensorProduct[outputtensor,Invg],{{s,Length[idx]+1}}],{Sequence@@Range[1,s-1],Sequence@@Range[s+1,Length[idx]],s}],
s===Length[idx],TensorContract[TensorProduct[outputtensor,Invg],{{s,Length[idx]+1}}]],
(* lower index; contract T^(i1 i2 ... j ... iD) Subscript[g, j is]; then transpose to get the right ordering of indices *)
(* last index does not need to be further transposed! *)
(Sgn[ttix[[s]]]===1)&&(Sgn[idx[[s]]]===-1),
outputtensor=Which[
s<Length[idx],Transpose[TensorContract[TensorProduct[outputtensor,g],{{s,Length[idx]+1}}],{Sequence@@Range[1,s-1],Sequence@@Range[s+1,Length[idx]],s}],
s===Length[idx],TensorContract[TensorProduct[outputtensor,g],{{s,Length[idx]+1}}]]
],{s,1,Length[idx]}];
(* output *)
tt/.{(TensorComponents->xxx123_)->(TensorComponents->outputtensor),(Indices->i123_):>(Indices->(i123/.outputindices))}
];


(* ::Input:: *)
(*(* old code *)
(*MoveIndices[tt_Tensor,idx_List,m_Tensor]/;((* check same number of active indices in tt and idx *)(Length[RemoveUnderBarredIndices[Indices[tt]]]===Length[idx])&&((* check idx contain proper indices *)Union[(CheckIndex/@idx)]==={True})&&((* check m is a Metric; we are going use it to move the indices with *)CheckMetricTensor[m])):=Module[*)
(*{tt1,outputindices,outidxRules,nx,sx,ix,ttix,g,Invg,\[Mu],\[Nu],\[Alpha],\[Beta],\[Sigma],ttM,i,pos,\[CapitalSigma],MetricG,si,comehere,iidx},*)
(*outidxRules=Thread[Rule[RemoveUnderBarredIndices[Indices[tt]],idx]];*)
(*(* idx may contain non-abstract indices; so we replace everything with dummy indices for now *)*)
(*ttix=(#/.{SuperMinus[sx_]\[Rule]SuperMinus[Unique[\[Mu]]],SuperPlus[sx_]\[Rule]SuperPlus[Unique[\[Mu]]]})&/@RemoveUnderBarredIndices[Indices[tt]];*)
(*(* replace indices with these dummy ones *)*)
(*tt1=tt/.Thread[Rule[RemoveUnderBarredIndices[Indices[tt]],ttix]];*)
(*(* do the same for idx using the same dummy symbols *)*)
(*iidx={};*)
(*Do[iidx=Append[iidx,idx\[LeftDoubleBracket]\[Sigma]\[RightDoubleBracket]/.{SuperMinus[sx_]\[Rule]SuperMinus[ttix\[LeftDoubleBracket]\[Sigma]\[RightDoubleBracket]\[LeftDoubleBracket]1\[RightDoubleBracket]],SuperPlus[sx_]\[Rule]SuperPlus[ttix\[LeftDoubleBracket]\[Sigma]\[RightDoubleBracket]\[LeftDoubleBracket]1\[RightDoubleBracket]]}],{\[Sigma],1,Length[idx]}];*)
(*(* we really only need to move indices when they are opposite in sign to those in tt *)*)
(*(* so first we delete everything in idx that shows up in ttix *)*)
(*ix=DeleteCases[iidx,xxxx_/;MemberQ[ttix,xxxx]];*)
(*If[ix==={},ttM=TensorComponents[tt];Goto[comehere]];*)
(*(* new indices for tt *)*)
(*(* outputindices=(ttix/.Thread[Rule[Which[Sgn[#]===1,SubMinus[#\[LeftDoubleBracket]1\[RightDoubleBracket]],Sgn[#]===-1,SuperMinus[#\[LeftDoubleBracket]1\[RightDoubleBracket]]]&/@ix,ix]]); *)*)
(*outputindices=Indices[tt]/.outidxRules;*)
(*(* compute metric and inverse and extract TensorComponents of tt *)*)
(*g[\[Mu]_,\[Nu]_]=Metric[Subscript[\[Mu], -],Subscript[\[Nu], -],m];*)
(*Invg[\[Mu]_,\[Nu]_]=Metric[\[Mu]^-,\[Nu]^-,m];*)
(*MetricG[\[Mu]_,\[Nu]_]/;(Sgn[\[Mu]]===Sgn[\[Nu]]):=Which[Sgn[\[Mu]]===1,Invg[\[Mu]\[LeftDoubleBracket]1\[RightDoubleBracket],\[Nu]\[LeftDoubleBracket]1\[RightDoubleBracket]],Sgn[\[Mu]]===-1,g[\[Mu]\[LeftDoubleBracket]1\[RightDoubleBracket],\[Nu]\[LeftDoubleBracket]1\[RightDoubleBracket]]];*)
(*(* set up dummy summation variables *)*)
(*\[CapitalSigma]=Thread[Rule[(#\[LeftDoubleBracket]1\[RightDoubleBracket]&/@ix),(Unique[\[Sigma]]&/@ix)]];*)
(*si=Flatten[Cases[m,(StartIndex\[Rule]iii_)\[Rule]iii,\[Infinity]]]\[LeftDoubleBracket]1\[RightDoubleBracket];*)
(*(* aum over contraction indices *)*)
(*ttM=Sum[((tt1/.\[CapitalSigma])(Times@@(MetricG[#,(#/.\[CapitalSigma])]&/@ix))),Evaluate[Sequence@@({(#\[LeftDoubleBracket]1\[RightDoubleBracket]/.\[CapitalSigma]),si,si+Length[Coordinates[m]]-1}&/@ix)]];*)
(*(* all relevant indices in new tt *)*)
(*ttM=Table[ttM,Evaluate[Sequence@@({#,si,si-1+Length[Coordinates[m]]}&/@((* all relevant indices in tt w/ contraction indices replaced with dummy ones *)Evaluate[(#\[LeftDoubleBracket]1\[RightDoubleBracket]&/@RemoveUnderBarredIndices[ttix])]))]];*)
(*(* output Tensor *)*)
(*Label[comehere];*)
(*tt/.{*)
(*(TensorComponents\[Rule]xxx123_)\[Rule](TensorComponents\[Rule]ttM),*)
(*(Indices\[Rule]i123_)\[Rule](Indices\[Rule]outputindices)*)
(*} *)
(*]; *)*)
(*(* MoveIndices[tt_Tensor,m_Tensor] basically returns tt with readily moveable indices *)*)
(*(* i.e. it returns output[\[Alpha],\[Beta],\[Gamma]...] where output = tt except the indices are automatically moved with the metric m if there were different from the original input *)*)
(*(* problem: how to create arbitrary number of arguments? *)*)
(*(* MoveIndices[tt_Tensor,m_Tensor]/;((* check m is a Metric; we are going use it to move the indices with *)(Cases[m,(TensorType\[Rule]tttt_)\[Rule]tttt,\[Infinity]]==={"Metric"})):=Module[{\[Alpha],idx,newix,i1,i2,op,n},*)
(*idx=RemoveUnderBarredIndices[Indices[tt]];*)
(*(* feed MoveIndices the original indices in tt, i.e. idx, except it is moved according to newix *)*)
(*Evaluate[(MoveIndices[tt,Table[Which[MatchQ[Slot[n],SuperMinus[_]],idx\[LeftDoubleBracket]n\[RightDoubleBracket]\[LeftDoubleBracket]1\[RightDoubleBracket]^-,MatchQ[Slot[n],SubMinus[_]],Subscript[idx\[LeftDoubleBracket]n\[RightDoubleBracket]\[LeftDoubleBracket]1\[RightDoubleBracket], -]],{n,1,Length[idx]}],m]/.((* after MoveIndices have moved the indices accordingly we need to replace the names with the ones in newix *)Table[Rule[idx\[LeftDoubleBracket]n\[RightDoubleBracket]\[LeftDoubleBracket]1\[RightDoubleBracket],Slot[n]\[LeftDoubleBracket]1\[RightDoubleBracket]],{n,1,Length[idx]}]))]&]; *)*)


(* ::Subsection::Closed:: *)
(*RaiseAllIndices*)


(* ::Input::Initialization:: *)
(* RaiseAllIndices[tt_Tensor,m_Tensor] returns tt with all its indices raised *)
RaiseAllIndices[t_Tensor,m_Tensor]/;CheckMetricTensor[m]:=Module[{idx},
(* strip off all the SubMinus and SuperMinus and then replace them all with SuperMinus *)
idx=SuperMinus[#]&/@(#[[1]]&/@RemoveUnderBarredIndices[Indices[t]]);
MoveIndices[t,idx,m]];


(* ::Subsection::Closed:: *)
(*LowerAllIndices*)


(* ::Input::Initialization:: *)
(* LowerAllIndices[tt_Tensor,m_Tensor] returns tt with all its indices lowered *)
LowerAllIndices[t_Tensor,m_Tensor]/;CheckMetricTensor[m]:=Module[{idx},
(* strip off all the SubMinus and SuperMinus and then replace them all with SuperMinus *)
idx=SubMinus[#]&/@(#[[1]]&/@RemoveUnderBarredIndices[Indices[t]]);
MoveIndices[t,idx,m]];


(* ::Subsection::Closed:: *)
(*UniqueIndices*)


(* ::Input::Initialization:: *)
(* UniqueIndices[tt_Tensor] returns tt with its indices made unique *)
UniqueIndices[t_Tensor]:=Module[{idx,xxx},
(* strip off the SubMinus and SuperMinus *)
idx=#[[1]]&/@RemoveUnderBarredIndices[Indices[t]];
(* replace them with Unique ones *)
idx=(#->Unique[#])&/@idx;
t/.(Indices->xxx_):>(Indices->(xxx/.idx))];


(* ::Subsection::Closed:: *)
(*PartialD*)


(* ::Input::Initialization:: *)
(* Partial derivative on a scalar: \!\(
\*SubscriptBox[\(\[Del]\), \(\[Mu]\)]stuff\) using the metric m *)
(* Same as CovariantD *)
PartialD[\[Mu]T_/;CheckIndex[\[Mu]T],stuff_,m_Tensor]/;((ScalarTest[stuff]||(Union[Cases[{stuff},Tensor[xx___],\[Infinity]]]==={}))&&(Cases[m,(TensorType->tt_)->tt,\[Infinity]]==={"Metric"})):=CovariantD[\[Mu]T,stuff,m];
(* Partial derivative \!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]Tensor\) using the metric m *)
(* Note III. Internally we build the PartialD as a Tensor with abstract indices then replace the \[PartialD]-index with \[Mu]T *)
PartialD[\[Mu]T_/;CheckIndex[\[Mu]T],\[Tau]T_Tensor,m_Tensor]/;((* We have already dealt with scalars *)(!ScalarTest[\[Tau]T])&&(* check m is a Metric *)(Cases[m,(TensorType->tt_)->tt]==={"Metric"})&&MatchQ[\[Mu]T,SubMinus[_]]):=Module[
{coords,\[Mu]TT,grad,\[Mu],\[Nu],\[Sigma],\[Lambda],\[Kappa],lgth,idx,ii,invmetricM,\[CapitalSigma],indices,TensorMatrix,ChristT,partialT,output,out,outputindices},
(* output Tensor has the following indices *)
outputindices={\[Mu]T,Sequence@@Indices[\[Tau]T]};
(* extract coordinates *)
coords=Coordinates[m];lgth=Length[coords];
(* extract StartIndex *)
idx=Cases[m,(StartIndex->ii_)->ii,\[Infinity]][[1]];
(* extract indices of \[Tau]T *)
indices=Indices[\[Tau]T];
(* extract components of \[PartialD](\[Tau]T) as a matrix *)
output=Table[D[\[Tau]T,coords[[\[Sigma]]]],
{\[Sigma],1,lgth},Evaluate[Sequence@@({#[[1]],idx,idx+lgth-1}&/@RemoveUnderBarredIndices[indices])]];
\[Tau]T/.{
(* We change the TensorType so that even the CovariantD of a Metric will be displayed properly *)
(TensorType->ttt_)->(TensorType->"PartialDerivative(s)"),
(Indices->iii_):>(Indices->Prepend[iii,\[Mu]T]),
(TensorName->nnn_):>(TensorName->"\[PartialD]"[Cases[\[Tau]T,(TensorName->nn_)->nn,\[Infinity]][[1]]]),
(TensorComponents->ccc_)->(TensorComponents->output)
}
];
(* Covariant derivative \[PartialD]^\[Mu]Tensor using the metric m *)
PartialD[\[Mu]T_/;CheckIndex[\[Mu]T],\[Tau]T_Tensor,m_Tensor]/;((* We have already dealt with scalars *)(!ScalarTest[\[Tau]T])&&(* check m is a Metric *)(Cases[m,(TensorType->tt_)->tt]==={"Metric"})&&MatchQ[\[Mu]T,SuperMinus[_]]):=Module[{\[Sigma],\[Mu]TT,tempT},
tempT=PartialD[SubMinus[\[Sigma]],\[Tau]T,m];
\[Tau]T/.{
(* We change the TensorType so that even the CovariantD of a Metric will be displayed properly *)
(TensorType->ttt_)->(TensorType->"PartialDerivative(s)"),
(Indices->iii_):>(Indices->Prepend[iii,\[Mu]T]),
(TensorName->nnn_):>(TensorName->"\[PartialD]"[Cases[\[Tau]T,(TensorName->nn_)->nn,\[Infinity]][[1]]]),
(TensorComponents->ccc_)->(TensorComponents->TensorContract[TensorProduct[TensorComponents[Metric[SuperMinus[\[Mu]TT],SuperMinus[\[Sigma]],m]],TensorComponents[tempT]],{{2,3}}])
}
];


(* ::Subsection::Closed:: *)
(*CovariantD*)


(* ::Input::Initialization:: *)
(* Covariant derivative on a scalar: \!\(
\*SubscriptBox[\(\[Del]\), \(\[Mu]\)]stuff\) using the metric m *)
(* stuff with no Tensor Head *)
CovariantD[\[Mu]T_/;CheckIndex[\[Mu]T],stuff_,m_Tensor]/;((Union[Cases[{stuff},Tensor[xx___],\[Infinity]]]==={})&&(Cases[m,(TensorType->tt_)->tt,\[Infinity]]==={"Metric"})&&MatchQ[\[Mu]T,SubMinus[_]]):=Module[
{coords,grad,\[Mu],\[Nu],\[Lambda],lgth,idx,ii,output},
(* extract coordinates *)
coords=Coordinates[m];lgth=Length[coords];
(* extract StartIndex *)
idx=Flatten[Cases[m,(StartIndex->ii_)->ii,\[Infinity]]][[1]];
(* return Tensor *)
output=(D[stuff,#]&/@coords);
Tensor[
TensorType->"Gradient",
TensorName->Del[stuff],
Indices->{\[Mu]T},StartIndex->idx,CoordinateSystem->coords,
TooltipDisplay->output,
TensorComponents->output
]
];
(* stuff w/ Tensor head *)
CovariantD[\[Mu]T_/;CheckIndex[\[Mu]T],stuff_Tensor,m_Tensor]/;((* check stuff is indeed a scalar *)ScalarTest[stuff]&&(Cases[m,(TensorType->tt_)->tt,\[Infinity]]==={"Metric"})&&MatchQ[\[Mu]T,SubMinus[_]]):=Module[
{coords,grad,\[Mu],\[Nu],\[Lambda],lgth,idx,ii,contents,output},
(* extract coordinates *)
coords=Coordinates[m];lgth=Length[coords];
(* extract StartIndex *)
idx=Flatten[Cases[m,(StartIndex->ii_)->ii,\[Infinity]]][[1]];
(* contents of stuff *)
contents=TensorComponents[stuff];
(* return Tensor *)
output=(D[contents,#]&/@coords);
Tensor[
TensorType->"Gradient",
TensorName->Del[Cases[stuff,(TensorName->ii_)->ii,\[Infinity]][[1]]],
Indices->{\[Mu]T},StartIndex->idx,CoordinateSystem->coords,
TooltipDisplay->output,
TensorComponents->output
]
];
(* Covariant derivative on a scalar: \[Del]^\[Mu]stuff using the metric m *)
(* stuff with no Tensor Head *)
CovariantD[\[Mu]T_/;CheckIndex[\[Mu]T],stuff_,m_Tensor]/;((Union[Cases[{stuff},Tensor[xx___],\[Infinity]]]==={})&&(Cases[m,(TensorType->tt_)->tt,\[Infinity]]==={"Metric"})&&MatchQ[\[Mu]T,SuperMinus[_]]):=Module[
{coords,grad,\[Mu],\[Nu],\[Lambda],lgth,idx,ii,invmetricM,output},
(* extract coordinates *)
coords=Coordinates[m];lgth=Length[coords];
(* extract StartIndex *)
idx=Flatten[Cases[m,(StartIndex->ii_)->ii,\[Infinity]]][[1]];
(* extract inverse metric as a matrix *)
invmetricM=TensorComponents[Metric[SuperMinus[\[Mu]],SuperMinus[\[Nu]],m]];
(* return Tensor *)
output=invmetricM . (D[stuff,#]&/@coords);
Tensor[
TensorType->"Gradient",
TensorName->Del[stuff],
Indices->{\[Mu]T},StartIndex->idx,
CoordinateSystem->coords,
(* g^\[Mu]\[Nu]\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]stuff\) *)
TooltipDisplay->output,
TensorComponents->output
]
];
(* stuff w/ Tensor head *)
CovariantD[\[Mu]T_/;CheckIndex[\[Mu]T],stuff_Tensor,m_Tensor]/;((* check stuff is indeed a scalar *)ScalarTest[stuff]&&(Cases[m,(TensorType->tt_)->tt,\[Infinity]]==={"Metric"})&&MatchQ[\[Mu]T,SuperMinus[_]]):=Module[
{coords,grad,\[Mu],\[Nu],\[Lambda],lgth,idx,ii,contents,invmetricM,output},
(* extract coordinates *)
coords=Coordinates[m];lgth=Length[coords];
(* extract StartIndex *)
idx=Flatten[Cases[m,(StartIndex->ii_)->ii,\[Infinity]]][[1]];
(* contents of stuff *)
contents=TensorComponents[stuff];
(* extract inverse metric as a matrix *)
invmetricM=TensorComponents[Metric[SuperMinus[\[Mu]],SuperMinus[\[Nu]],m]];
(* return Tensor *)
output=invmetricM . (D[contents,#]&/@coords);
Tensor[
TensorType->"Gradient",
TensorName->Del[Cases[stuff,(TensorName->ii_)->ii,\[Infinity]][[1]]],
Indices->{\[Mu]T},StartIndex->idx,CoordinateSystem->coords,
TooltipDisplay->output,
TensorComponents->output
]
];


(* ::Input::Initialization:: *)
(* Covariant derivative \!\(
\*SubscriptBox[\(\[Del]\), \(\[Mu]\)]Tensor\) using the metric m *)
(* Note I. If \[Tau]T contains non-repeated UnderBarred indices then we cannot take its CovariantD because there isn't enough info since we'd have to sum over other components of the Tensor that are not available. *)
(* Note II. If \[Tau]T contains repeated UnderBarred indices ___ SubMinus[UnderBar[\[Mu]]] ___ SuperMinus[UnderBar[\[Mu]]] ___ then these indices are "scalars" and do not take part in the CovariantD process *)
(* Note III. Internally we build the CovariantD as a Tensor with abstract indices then replace the Del-index with \[Mu]T *)
CovariantD[\[Mu]T_/;CheckIndex[\[Mu]T],\[Tau]T_Tensor,m_Tensor]/;((* We have already dealt with scalars *)(!ScalarTest[\[Tau]T])&&(* check m is a Metric *)(Cases[m,(TensorType->tt_)->tt]==={"Metric"})&&MatchQ[\[Mu]T,SubMinus[_]]&&((* check for non-repeating UnderBarred Indices *)RemoveRepeatedUnderBarredIndices[Union[Flatten[Cases[Indices[\[Tau]T],(SuperMinus|SubMinus)[UnderBar[_]],\[Infinity]]]]]==={})):=Module[
{coords,ttM,\[Mu]TT,\[CapitalGamma]M,grad,\[Mu],\[Nu],\[Sigma],\[Lambda],\[Kappa],lgth,idx,ii,invmetricM,\[CapitalSigma],indices,TensorMatrix,ChristT,partialT,output,out,outputindices},
(* Christoffel symbol *)
\[CapitalGamma]M=TensorComponents[Christoffel[SuperMinus[\[Mu]],SubMinus[\[Nu]],SubMinus[\[Sigma]],m]];
(* output Tensor has the following indices *)
outputindices={\[Mu]T,Sequence@@Indices[\[Tau]T]};
(* extract coordinates *)
coords=Coordinates[m];lgth=Length[coords];
(* extract StartIndex *)
idx=Cases[m,(StartIndex->ii_)->ii,\[Infinity]][[1]];
(* extract indices of \[Tau]T *)
(* remove repeated UnderBarred indices because they are irrelevant as far as CovariantD is concerned *)
indices=RemoveRepeatedUnderBarredIndices[Indices[\[Tau]T]];
(* extract components of \[Tau]T as a matrix *)
TensorMatrix=TensorComponents[\[Tau]T];
(* prepare summation indices *)
(* ... first prepare summation indices *)
\[CapitalSigma]=Unique[\[Sigma]]&/@Range[1,Length[indices]];
(* ... then prepare summation indices and their summation range 1...d *)
\[Lambda]=Thread[{\[CapitalSigma],1,Dimensions[TensorMatrix]}];
\[Kappa]=(#[[1]]&/@\[Lambda]);
(* partial derivative terms *)
partialT=Table[D[TensorMatrix,coords[[\[Sigma]]]],{\[Sigma],1,Length[coords]}(*,Evaluate[(Sequence@@\[Lambda])]*)];
(* Christoffel terms *)
(* be careful re. ordering of indices *)
(* We contract Christoffel with Tensor (wrt to appropriate slot) term-by-term *)
(* ChristT=({Sgn[#],(* make sure the ordering of indices is correct *)SwapIndices[Which[
Sgn[#]===1,ContractTensors[Christoffel[#,Subscript[\[Mu]TT, -],Subscript[\[Sigma], -],m](\[Tau]T/.#\[Rule]\[Sigma]^-)],
Sgn[#]===-1,ContractTensors[Christoffel[\[Sigma]^-,Subscript[\[Mu]TT, -],#,m](\[Tau]T/.#\[Rule]Subscript[\[Sigma], -])]],
		RemoveRepeatedUnderBarredIndices[{Subscript[\[Mu]TT, -],Sequence@@Indices[\[Tau]T]}]]}&/@indices); *)
(* commented out code is a bit cryptic so let's do it slightly more directly? *)
(* \!\(
\*SubscriptBox[\(\[Del]\), \(\[Mu]\)]\ 
\*SubscriptBox[
SuperscriptBox[\(T\), \(\(\(...\)\(\ \)\(\[Alpha]\)\)\  ... \)], \(\(\(...\)\(\ \)\(\[Beta]\)\)\  ... \)]\) = ... + Subscript[\[CapitalGamma]^\[Alpha], \[Mu]\[Sigma]] Subscript[T^(... \[Sigma] ...), ... \[Beta] ...] - Subscript[\[CapitalGamma]^\[Sigma], \[Mu]\[Beta]] Subscript[T^(... \[Alpha] ...), ... \[Sigma] ...] *)
(* old code
\[Lambda]=Thread[{\[CapitalSigma],idx,idx+lgth-1}];
ChristT=((Sgn[#] Which[
Sgn[#]===1,Sum[Christoffel[#,Subscript[\[Mu]TT, -],Subscript[\[Sigma], -],m](\[Tau]T/.#\[Rule]\[Sigma]^-),{\[Sigma],idx,idx+lgth-1}],
Sgn[#]===-1,Sum[Christoffel[\[Sigma]^-,Subscript[\[Mu]TT, -],#,m](\[Tau]T/.#\[Rule]Subscript[\[Sigma], -]),{\[Sigma],idx,idx+lgth-1}]])&/@indices);
ChristT=Table[Plus@@(ChristT/.Thread[Rule[(#\[LeftDoubleBracket]1\[RightDoubleBracket]&/@indices),\[CapitalSigma]]]),{\[Mu]TT,idx,idx+lgth-1},Evaluate[(Sequence@@\[Lambda])]];
*)
(* new code May 2016 *)
ChristT={};
Do[
ChristT=Append[ChristT,Sgn[indices[[\[Sigma]]]]Transpose[TensorContract[TensorProduct[\[CapitalGamma]M,TensorMatrix],{{Which[Sgn[indices[[\[Sigma]]]]==1,3,Sgn[indices[[\[Sigma]]]]==-1,1],3+\[Sigma]}}],Which[Sgn[indices[[\[Sigma]]]]==1,{\[Sigma]+1,1,Sequence@@Range[2,\[Sigma]],Sequence@@Range[\[Sigma]+2,Length[indices]+1]},Sgn[indices[[\[Sigma]]]]==-1,{1,\[Sigma]+1,Sequence@@Range[2,\[Sigma]],Sequence@@Range[\[Sigma]+2,Length[indices]+1]}]]],{\[Sigma],1,Length[indices]}];
ChristT=Plus@@ChristT;
(* ChristT=(#\[LeftDoubleBracket]1\[RightDoubleBracket]TensorComponents[#\[LeftDoubleBracket]2\[RightDoubleBracket]])&/@ChristT; *)
(* combine the terms and sum them *)
(* output=Prepend[ChristT,partialT];output=Plus@@output; *)
output=partialT+ChristT;
(* return Tensor by prepending Del-index \[Mu]T and Applying Del to TensorName and replacing TensorComponents *)
\[Tau]T/.{
(* We change the TensorType so that even the CovariantD of a Metric will be displayed properly *)
(TensorType->ttt_)->(TensorType->"CovariantDerivative(s)"),
(Indices->iii_):>(Indices->Prepend[iii,\[Mu]T]),
(TensorName->nnn_):>(TensorName->Del[Cases[\[Tau]T,(TensorName->nn_)->nn,\[Infinity]][[1]]]),
(TensorComponents->ccc_)->(TensorComponents->output)
}
];
(* Covariant derivative \[Del]^\[Mu]Tensor using the metric m *)
CovariantD[\[Mu]T_/;CheckIndex[\[Mu]T],\[Tau]T_Tensor,m_Tensor]/;((* We have already dealt with scalars *)(!ScalarTest[\[Tau]T])&&(* check m is a Metric *)(Cases[m,(TensorType->tt_)->tt]==={"Metric"})&&MatchQ[\[Mu]T,SuperMinus[_]]):=Module[{\[Sigma],\[Mu]TT,tempT},
tempT=CovariantD[SubMinus[\[Sigma]],\[Tau]T,m];
\[Tau]T/.{
(* We change the TensorType so that even the CovariantD of a Metric will be displayed properly *)
(TensorType->ttt_)->(TensorType->"CovariantDerivative(s)"),
(Indices->iii_):>(Indices->Prepend[iii,\[Mu]T]),
(TensorName->nnn_):>(TensorName->Del[Cases[\[Tau]T,(TensorName->nn_)->nn,\[Infinity]][[1]]]),
(TensorComponents->ccc_)->(TensorComponents->TensorContract[TensorProduct[TensorComponents[Metric[SuperMinus[\[Mu]TT],SuperMinus[\[Sigma]],m]],TensorComponents[tempT]],{{2,3}}])
}
];


(* ::Input::Initialization:: *)
(* Thread over Plus automatically *)
CovariantD/:CovariantD[\[Mu]T_,tt_,m_]:=(CovariantD[\[Mu]T,#,m]&/@tt)/;(Head[tt]===Plus); 
(* Implement product rule *)
CovariantD/:CovariantD[\[Mu]T_,tt_,m_]:=Module[{allTensors,therest},
allTensors=Times@@Cases[(List@@tt),_Tensor];
therest=Times@@DeleteCases[(List@@tt),_Tensor];
therest CovariantD[\[Mu]T,allTensors,m]+allTensors Which[TensorIsZero[CovariantD[\[Mu]T,therest,m]],0,True,CovariantD[\[Mu]T,therest,m]]]/;(Head[tt]===Times)&&(Union[(Head/@(List@@tt))]=!={Tensor});
(* Use ContractTensors to take care of TensorProduct's of Tensors *)
CovariantD/:CovariantD[\[Mu]T_,tt_,m_]:=CovariantD[\[Mu]T,ContractTensors[tt],m]/;((Head[tt]===Times)&&(Union[(Head/@(List@@tt))]==={Tensor}));


(* ::Subsection::Closed:: *)
(*CovariantBox*)


(* ::Input::Initialization:: *)
(* Box on scalar function f *)
(* = g^{-1/2} \[PartialD]_\[Mu] ( g^{1/2} g^{\[Mu]\[Nu]} \[PartialD]_\[Nu] f ) *)
(* = \[PartialD]_\[Mu] ( g^{\[Mu]\[Nu]} \[PartialD]_\[Nu] f ) + (\[PartialD]_\[Mu] ln g^{1/2}) g^{\[Mu]\[Nu]} \[PartialD]_\[Nu] f *)
(* = \[PartialD]_\[Mu] ( g^{\[Mu]\[Nu]} \[PartialD]_\[Nu] f ) + \[CapitalGamma]^\[Mu]_{\[Mu]\[Lambda]} g^{\[Lambda]\[Nu]} \[PartialD]_\[Nu] f *)
CovariantBox[stuff_,m_Tensor]/;((Union[Cases[{stuff},Tensor[xx_],\[Infinity]]]==={})&&(Cases[m,(TensorType->tt_)->tt]==={"Metric"})):=Module[
{coords,grad,\[Mu],\[Nu],\[Lambda],lgth,idx,ii},
coords=Coordinates[m];lgth=Length[coords];
(* extract StartIndex *)
idx=Flatten[Cases[m,(StartIndex->ii_)->ii,\[Infinity]]][[1]];
(* g^{\[Mu]\[Nu]} \[PartialD]_\[Nu] stuff *)
grad=Table[
Sum[Metric[SuperMinus[\[Mu]],SuperMinus[\[Nu]],m]D[stuff,coords[[\[Nu]-idx+1]]],{\[Nu],idx,idx+lgth-1}],
{\[Mu],idx,idx+lgth-1}
];
(* \[PartialD]_\[Mu] grad^\[Mu] + \[CapitalGamma]^\[Mu]_{\[Mu]\[Nu]} grad^\[Nu] *)
Sum[D[grad[[\[Nu]-idx+1]],coords[[\[Nu]-idx+1]]]+Sum[Christoffel[SuperMinus[\[Mu]],SubMinus[\[Mu]],SubMinus[\[Nu]],m],{\[Mu],idx,idx+lgth-1}]grad[[\[Nu]-idx+1]],{\[Nu],idx,idx+lgth-1}]
];


(* ::Subsection::Closed:: *)
(*CoordinateTransformation*)


(* ::Input::Initialization:: *)
(* Compute Jacobians for coordinate transformations *)
(* Enter r = {x \[Rule] f1[x,y,z,...], y \[Rule] f2[x,y,z,...], z \[Rule] f3[x,y,z,...], ...} *)
(* returns Union[r, {dx \[Rule] (\[PartialD]f1/\[PartialD]x)\[DifferentialD]x + (\[PartialD]f1/\[PartialD]y)\[DifferentialD]y + ..., dy \[Rule] (\[PartialD]f2/\[PartialD]x)\[DifferentialD]x + (\[PartialD]f2/\[PartialD]y)\[DifferentialD]y + ...} ] *)
CoordinateTransformation[ct:{Repeated[Rule[_Symbol,_]]}]:=Module[
{coords,rhs,jacob,i,j,ds},
coords=#[[1]]&/@ct;rhs=#[[2]]&/@ct;
(* dx \[Rule] (dx'/dx) dx *)
jacob[i_]:=Sum[D[rhs[[i]],coords[[j]]]\[DifferentialD]coords[[j]],{j,1,Length[coords]}];
ds=(\[DifferentialD]coords[[#]]->jacob[#])&/@Range[1,Length[coords]];
Flatten[{ds,ct}]
];
(* Enter r = {x \[Rule] f1[x',y',z',...], y \[Rule] f2[x',y',z',...], z \[Rule] f3[x',y',z',...], ...} *)
(* i.e. allow for different names on the RHS than the previous *)
(* returns Union[r, {dx \[Rule] (\[PartialD]f1/\[PartialD]x')\[DifferentialD]x' + (\[PartialD]f1/\[PartialD]y')\[DifferentialD]y' + ..., dy \[Rule] (\[PartialD]f2/\[PartialD]x')\[DifferentialD]x' + (\[PartialD]f2/\[PartialD]y')\[DifferentialD]y' + ...} ] *)
CoordinateTransformation[ct:{Repeated[Rule[_Symbol,_]]},newcoords:{Repeated[_Symbol]}]:=Module[
{coords,rhs,jacob,i,j,ds},
(* extract coordinates and transformation rules *)
coords=#[[1]]&/@ct;rhs=#[[2]]&/@ct;
(* dx \[Rule] (dx_old'/dx_new) dx_new *)
jacob[i_]:=Sum[D[rhs[[i]],newcoords[[j]]]\[DifferentialD]newcoords[[j]],{j,1,Length[newcoords]}];
ds=(\[DifferentialD]coords[[#]]->jacob[#])&/@Range[1,Length[coords]];
Flatten[{ds,ct}]
];


(* ::Input::Initialization:: *)
(* Coordinate transform a metric *)
(* Enter r = {x \[Rule] f1[x,y,z,...], y \[Rule] f2[x,y,z,...], z \[Rule] f3[x,y,z,...], ...} *)
CoordinateTransformation[mt_Tensor,ct:{Repeated[Rule[_Symbol,_]]},opts:OptionsPattern[]]/;(((* check Metric *)Cases[mt,(TensorType->tt_)->tt]==={"Metric"})&&((* check same coordinates *)Sort[#[[1]]&/@ct]===Sort[Coordinates[mt]])):=Module[
{coords,i,j,ds2,si,op},
(* extract coordinates *)
coords=#[[1]]&/@ct;
(* extract StartIndex so we know what to sum over below *)
si=Cases[mt,(StartIndex->mmm_)->mmm,\[Infinity]][[1]];
(* extract metric in the form of coordinate differentials *)
ds2=TensorComponents[Metric[SubMinus[i],SubMinus[j],mt]];
ds2=Sum[ds2[[i,j]]\[DifferentialD]coords[[i]] \[DifferentialD]coords[[j]],{i,1,Length[coords]},{j,1,Length[coords]}];
(* Apply CoordinateTransformation *)
op=OptionValue[CoordinateTransformationOperator];
ds2=(ds2/.CoordinateTransformation[ct])//op;
(* Re-compute Metric using new coordinates *)
(* ensure the StartIndex and TensorName are brought over *)
ds2=Metric[SubMinus[i],SubMinus[j],ds2,CoordinateSystem->coords,StartIndex->si,TensorName->Cases[mt,(TensorName->mmm_)->mmm,\[Infinity]][[1]]];
(* output with the same indices *)
Metric[Sequence@@Indices[mt],ds2]
];
(* Enter r = {x \[Rule] f1[x',y',z',...], y \[Rule] f2[x',y',z',...], z \[Rule] f3[x',y',z',...], ...} *)
(* i.e. allow for different names on the RHS than the previous *)
CoordinateTransformation[mt_Tensor,ct:{Repeated[Rule[_Symbol,_]]},newcoords:{Repeated[_Symbol]},opts:OptionsPattern[]]/;(((* check Metric *)Cases[mt,(TensorType->tt_)->tt]==={"Metric"})&&((* check same coordinates *)Sort[#[[1]]&/@ct]===Sort[Coordinates[mt]])&&((* check same dimension *)Length[#[[1]]&/@ct]===Length[newcoords])):=Module[
{coords,i,j,ds2,si,op},
(* extract old coordinates *)
coords=#[[1]]&/@ct;
(* extract StartIndex so we know what to sum over below *)
si=Cases[mt,(StartIndex->mmm_)->mmm,\[Infinity]][[1]];
(* extract metric in the form of coordinate differentials *)
ds2=TensorComponents[Metric[SubMinus[i],SubMinus[j],mt]];
ds2=Sum[ds2[[i,j]]\[DifferentialD]coords[[i]] \[DifferentialD]coords[[j]],{i,1,Length[coords]},{j,1,Length[coords]}];
(* Apply CoordinateTransformation *)
op=OptionValue[CoordinateTransformationOperator];
ds2=(ds2/.CoordinateTransformation[ct,newcoords])//op;
(* Re-compute Metric using new coordinates *)
(* ensure new coordinates, StartIndex and TensorName are brought over *)
ds2=Metric[SubMinus[i],SubMinus[j],ds2,CoordinateSystem->newcoords,StartIndex->si,TensorName->Cases[mt,(TensorName->mmm_)->mmm,\[Infinity]][[1]]];
(* output with the same indices *)
Metric[Sequence@@Indices[mt],ds2]
];


(* ::Subsection::Closed:: *)
(*GradientSquared*)


(* ::Input::Initialization:: *)
(* (\[Del]f)^2 for scalar function f *)
(* this code is borrowed from CovariantBox *)
GradientSquared[stuff_,m_Tensor]/;((Union[Cases[{stuff},Tensor[xx_],\[Infinity]]]==={})&&(Cases[m,(TensorType->tt_)->tt]==={"Metric"})):=Module[
{coords,gradu,gradd,\[Mu],\[Nu],\[Lambda],lgth,idx,ii},
coords=Coordinates[m];lgth=Length[coords];
(* extract StartIndex *)
idx=Flatten[Cases[m,(StartIndex->ii_)->ii,\[Infinity]]][[1]];
(* g^{\[Mu]\[Nu]} \[PartialD]_\[Nu] stuff *)
gradu=Table[
Sum[Metric[SuperMinus[\[Mu]],SuperMinus[\[Nu]],m]D[stuff,coords[[\[Nu]-idx+1]]],{\[Nu],idx,idx+lgth-1}],
{\[Mu],idx,idx+lgth-1}
];
(* \[PartialD]_\[Mu] stuff *)
gradd=Table[D[stuff,coords[[\[Nu]-idx+1]]],{\[Nu],idx,idx+lgth-1}];
(* \[PartialD]_\[Mu] stuff g^{\[Mu]\[Nu]} \[PartialD]_\[Nu] stuff = gradd.gradu *)
gradu . gradd
]


(* ::Subsection::Closed:: *)
(*TensorIsZero*)


(* ::Input::Initialization:: *)
(* TensorIsZero returns True if every component of the input Tensor is zero and False otherwise *)
TensorIsZero[stuff_Tensor]:=Which[
(* non-scalar *)Head[TensorComponents[stuff]]===List,(Union[Flatten[TensorComponents[stuff]]]==={0}),
True,((* scalar case *)TensorComponents[stuff]===0)];


(* ::Subsection::Closed:: *)
(*LeviCivita*)


(* ::Input::Initialization:: *)
LeviCivita[\[Nu]I__,m_Tensor]/;CheckMetricTensor[m]&&((* check space(time) dimensions *)Length[{\[Nu]I}]===Length[Coordinates[m]])&&(Union[CheckIndex/@{\[Nu]I}]==={True}):=Module[
{mm,ss,\[Sigma],\[Sigma]1,\[Sigma]2,\[Mu],\[Nu],\[Alpha],\[Beta],\[Mu]1,\[Nu]1,\[Alpha]1,\[Beta]1,rl,si,s1,s2,\[CapitalSigma]1,\[CapitalSigma]2,cooo,disp,d,cc,LeviCivitaTemp,RL,gDD,gUU,K\[Delta]},
cooo=Coordinates[m];
d=Length[cooo];
si=Cases[m,(StartIndex->cc_)->cc][[1]];
(* prepare summation indices *)
\[CapitalSigma]1=Unique[\[Sigma]1]&/@Range[1,d];s1={\[CapitalSigma]1[[#]],1,d}&/@Range[1,d];
mm=Power[Abs[Determinant[m]],1/2]Table[Signature[\[CapitalSigma]1],Evaluate[Sequence@@s1]];
disp="Volume form";
(* LeviCivita w/ lower indices *)
LeviCivitaTemp=Tensor[
TensorType->"VolumeForm",
TensorName->OverTilde["\[Epsilon]"],
CoordinateSystem->cooo,
TensorComponents->mm,
StartIndex->si,
Indices->(SubMinus[Unique[\[Sigma]]]&/@{\[Nu]I}),
TooltipDisplay->disp
];
MoveIndices[LeviCivitaTemp,{\[Nu]I},m]
];


(* ::Subsection::Closed:: *)
(*CovariantHodgeDual*)


(* ::Input::Initialization:: *)
(* Implement the covariant Hodge Dual of Tensor \[Tau] using the Metric m *)
(* When # of Indices of \[Tau] is less than the # of dimensions *)
CovariantHodgeDual[\[Nu]I__,\[Tau]_Tensor,m_Tensor]/;CheckMetricTensor[m]&&(Coordinates[\[Tau]]===Coordinates[m])&&(Union[CheckIndex/@{\[Nu]I}]==={True})&&(Length[{\[Nu]I}]===Simplify[Length[Coordinates[m]]-Length[RemoveUnderBarredIndices[Indices[\[Tau]]]]]):=Module[
{mm,LCT,\[Sigma],\[Sigma]1,\[Sigma]2,\[Mu],\[Nu],\[Alpha],\[Beta],\[Mu]1,\[Nu]1,\[Alpha]1,\[Beta]1,rl,s,si,s1,s2,\[CapitalSigma],\[CapitalSigma]1,\[CapitalSigma]2,cooo,disp,d,cc,LeviCivitaTemp,RL,gDD,gUU,K\[Delta]},
(* strategy: construct appropriate LeviCivita and then contract it with the Tensor \[Tau] *)
(* first construct dummy indices from the Indices of \[Tau] *)
(* remember to removeunderbarred indices *)
\[CapitalSigma]=Unique[\[Sigma]]&/@(#[[1]]&/@RemoveUnderBarredIndices[Indices[\[Tau]]]);
(* Levi-Civita tensor with the indices \[Nu]I appended with all lower indices *)
LCT=(TensorComponents[LeviCivita[\[Nu]I,(Sequence@@(SubMinus/@\[CapitalSigma])),m]]/Length[RemoveUnderBarredIndices[Indices[\[Tau]]]]!);
(* now tensor it with \[Tau] and then contract *)
s=Length[{\[Nu]I}];
LCT=TensorContract[TensorProduct[LCT,TensorComponents[RaiseAllIndices[\[Tau],m]]],Table[{s+si,s+si+Length[RemoveUnderBarredIndices[Indices[\[Tau]]]]},{si,1,Length[RemoveUnderBarredIndices[Indices[\[Tau]]]]}]];
\[Tau]/.{(* replace name *)
(TensorName->s1_):>(TensorName->Row[{"\[FivePointedStar]",s1}]),
(* replace tensorcomponents *)
(TensorComponents->s2_)->(TensorComponents->LCT),
(* replace Indices *)
(Indices->s2_)->(Indices->{\[Nu]I})
}
]/;((* make sure \[Tau] is fully antisymmetric *)TensorSymmetry[TensorComponents[\[Tau]]]===Antisymmetric[Range[1,Length[RemoveUnderBarredIndices[Indices[\[Tau]]]]]]);
(* When # of Indices of \[Tau] equal to # of dimensions *)
CovariantHodgeDual[\[Tau]_Tensor,m_Tensor]/;CheckMetricTensor[m]&&(Coordinates[\[Tau]]===Coordinates[m])&&(Length[RemoveUnderBarredIndices[Indices[\[Tau]]]]===Length[Coordinates[m]]):=Module[
{mm,LCT,\[Sigma],\[Sigma]1,\[Sigma]2,\[Mu],\[Nu],\[Alpha],\[Beta],\[Mu]1,\[Nu]1,\[Alpha]1,\[Beta]1,rl,s,si,s1,s2,\[CapitalSigma],\[CapitalSigma]1,\[CapitalSigma]2,cooo,disp,d,cc,LeviCivitaTemp,RL,gDD,gUU,K\[Delta]},
(* dimension *)
d=Length[Coordinates[m]];
(* strategy: construct appropriate LeviCivita and then contract it with the Tensor \[Tau] *)
(* first construct dummy indices from the Indices of \[Tau] *)
(* remember to removeunderbarred indices *)
\[CapitalSigma]=Unique[\[Sigma]]&/@Range[1,d];
(* Levi-Civita tensor with all lower indices *)
LCT=(TensorComponents[LeviCivita[(Sequence@@(SubMinus/@\[CapitalSigma])),m]]/d!);
(* now tensor it with \[Tau] and then contract *)
LCT=TensorContract[TensorProduct[LCT,TensorComponents[RaiseAllIndices[\[Tau],m]]],Table[{si,d+si},{si,1,d}]];
\[Tau]/.{(* replace name *)
(TensorName->s1_):>(TensorName->Row[{"\[FivePointedStar]",s1}]),
(* replace tensorcomponents *)
(TensorComponents->s2_)->(TensorComponents->LCT),
(* replace Indices *)
(Indices->s2_)->(Indices->{})
}
]/;((* make sure \[Tau] is fully antisymmetric *)TensorSymmetry[TensorComponents[\[Tau]]]===Antisymmetric[Range[1,Length[RemoveUnderBarredIndices[Indices[\[Tau]]]]]]);


(* ::Subsection::Closed:: *)
(*GeodesicSystem, GeodesicLagrangians, GeodesicHamiltonianDynamics*)


(* ::Text:: *)
(*GeodesicSystem takes as input*)
(*{Metric Tensor, AffineParameter, NonAffineParameter}*)
(*and produces as output:*)
(*{Lagrangian for geodesic motion in affine parameter form, *)
(*Lag. non-affine parameter form, *)
(*Geodesic equations in affine parameter,*)
(*Geodesic equations in non-affine parameter forms}*)


(* ::Input::Initialization:: *)
GeodesicSystem[m_Tensor,opts:OptionsPattern[]]/;CheckMetricTensor[m]:=Module[
{mm,ss,\[Sigma],\[Mu],\[Nu],si,cooo,d,cc,coo\[Lambda],coot,a\[Lambda],ct,comehere,L\[Lambda],Lt,output},
(* extract affine and non-affine parameter for solving geodesic eqn *)
a\[Lambda]=OptionValue[AffineParameter];
cooo=Coordinates[m];
(* non-affine parameter *)
ct=Intersection[{OptionValue[NonAffineParameter]},cooo];
Which[
(* if input NonAffineParameter is one of the coordinates *)
Length[ct]===1,
coot=Which[#===ct[[1]],ct[[1]],#=!=ct[[1]],#/.#->#[ct[[1]]]]&/@cooo,
(* if input NonAffineParameter is not one of the coordinates *)
ct==={},
coot=(#/.#->#[OptionValue[NonAffineParameter]])&/@cooo];
ct=OptionValue[NonAffineParameter];
(* coordinates as a function of affine parameter *)
coo\[Lambda]=(#/.#->#[a\[Lambda]])&/@cooo;
d=Length[cooo];
(* construct affine parameter Lagrangian *)
L\[Lambda]=TensorComponents[Metric[SubMinus[\[Mu]],SubMinus[\[Nu]],m]]/.Thread[Rule[cooo,coo\[Lambda]]];
L\[Lambda]=(1/2)Sum[L\[Lambda][[\[Mu],\[Nu]]]D[coo\[Lambda],a\[Lambda]][[\[Mu]]]D[coo\[Lambda],a\[Lambda]][[\[Nu]]],{\[Mu],1,d},{\[Nu],1,d}];
(* construct non-affine parameter Lagrangian *)
Lt=TensorComponents[Metric[SubMinus[\[Mu]],SubMinus[\[Nu]],m]]/.Thread[Rule[cooo,coot]];
Lt=Power[Sum[Lt[[\[Mu],\[Nu]]]D[coot,ct][[\[Mu]]]D[coot,ct][[\[Nu]]],{\[Mu],1,d},{\[Nu],1,d}],1/2];
(* output: 
(1) Lag in affine parameter form, Lag in non-affine parameter form;
(2) Geodesic Equations in affine parameter form;
(3) Geodesic Equations in non-affine parameter form *)
{L\[Lambda],Lt,EulerEquations[L\[Lambda],coo\[Lambda],a\[Lambda]],EulerEquations[Lt,Complement[coot,{ct}],ct]}
]/;((Head[OptionValue[AffineParameter]]===Symbol)&&(Head[OptionValue[NonAffineParameter]]===Symbol));


(* ::Text:: *)
(*GeodesicLagrangians takes as input*)
(*{Metric Tensor, AffineParameter, NonAffineParameter}*)
(*and produces as output:*)
(*{Lagrangian for geodesic motion in affine parameter form, *)
(*Lag. non-affine parameter form}*)
(*That is, it is GeodesicSystem, except it does not compute the geodesic equations.*)


(* ::Input::Initialization:: *)
GeodesicLagrangians[m_Tensor,opts:OptionsPattern[]]/;CheckMetricTensor[m]:=Module[
{mm,ss,\[Sigma],\[Mu],\[Nu],si,cooo,d,cc,coo\[Lambda],coot,a\[Lambda],ct,comehere,L\[Lambda],Lt,output},
(* extract affine and non-affine parameter for solving geodesic eqn *)
a\[Lambda]=OptionValue[AffineParameter];
cooo=Coordinates[m];
(* non-affine parameter *)
ct=Intersection[{OptionValue[NonAffineParameter]},cooo];
Which[
(* if input NonAffineParameter is one of the coordinates *)
Length[ct]===1,
coot=Which[#===ct[[1]],ct[[1]],#=!=ct[[1]],#/.#->#[ct[[1]]]]&/@cooo,
(* if input NonAffineParameter is not one of the coordinates *)
ct==={},
coot=(#/.#->#[OptionValue[NonAffineParameter]])&/@cooo];
ct=OptionValue[NonAffineParameter];
(* coordinates as a function of affine parameter *)
coo\[Lambda]=(#/.#->#[a\[Lambda]])&/@cooo;
d=Length[cooo];
(* construct affine parameter Lagrangian *)
L\[Lambda]=TensorComponents[Metric[SubMinus[\[Mu]],SubMinus[\[Nu]],m]]/.Thread[Rule[cooo,coo\[Lambda]]];
L\[Lambda]=(1/2)Sum[L\[Lambda][[\[Mu],\[Nu]]]D[coo\[Lambda],a\[Lambda]][[\[Mu]]]D[coo\[Lambda],a\[Lambda]][[\[Nu]]],{\[Mu],1,d},{\[Nu],1,d}];
(* construct non-affine parameter Lagrangian *)
Lt=TensorComponents[Metric[SubMinus[\[Mu]],SubMinus[\[Nu]],m]]/.Thread[Rule[cooo,coot]];
Lt=Power[Sum[Lt[[\[Mu],\[Nu]]]D[coot,ct][[\[Mu]]]D[coot,ct][[\[Nu]]],{\[Mu],1,d},{\[Nu],1,d}],1/2];
(* output: 
(1) Lag in affine parameter form, Lag in non-affine parameter form *)
{L\[Lambda],Lt}
]/;((Head[OptionValue[AffineParameter]]===Symbol)&&(Head[OptionValue[NonAffineParameter]]===Symbol));


(* ::Text:: *)
(*GeodesicHamiltonianDynamics takes as input*)
(*{Metric Tensor, {coordinates -> momenta}, AffineParameter}*)
(*and produces as output:*)
(*{Hamiltonian for geodesic motion in affine parameter form, *)
(*{x-dot = \[PartialD]H/\[PartialD]p,p-dot = -\[PartialD]H/\[PartialD]x}}.*)


(* ::Input::Initialization:: *)
GeodesicHamiltonianDynamics[m_Tensor,cp_List,a\[Lambda]_Symbol]/;CheckMetricTensor[m]&&(* list of Rules relating coords to momenta *)MatchQ[cp[[1]],Repeated[Rule[lhs_,rhs_]]]&&(* lhs of Rules in cp should be the coordinates of m *)(Union[Evaluate[(cp/.Rule[lhs_,rhs_]->lhs)],Coordinates[m]]===Sort[Coordinates[m]])&&(* Affine Parameter should not be coordinate *)(Intersection[Coordinates[m],{a\[Lambda]}]==={}):=Module[
{mm,ss,\[Sigma],\[Mu],\[Nu],si,cooo,d,cc,coo\[Lambda],p\[Lambda],coot,ct,comehere,H\[Lambda],g\[Mu]\[Nu],Lt,output,coo\[Lambda]Eqn,p\[Lambda]Eqn},
(* extract affine and non-affine parameter for solving geodesic eqn *)
cooo=Coordinates[m];
(* coordinates as a function of affine parameter *)
coo\[Lambda]=(#/.#->#[a\[Lambda]])&/@cooo;
(* momentum as a function of affine parameter *)
p\[Lambda]=(#/.#->#[a\[Lambda]])&/@(cooo/.cp);
d=Length[cooo];
(* construct affine parameter Hamiltonian *)
g\[Mu]\[Nu]=TensorComponents[Metric[SuperMinus[\[Mu]],SuperMinus[\[Nu]],m]]/.Thread[Rule[cooo,coo\[Lambda]]];
H\[Lambda]=(1/2)Sum[g\[Mu]\[Nu][[\[Mu],\[Nu]]]p\[Lambda][[\[Mu]]]p\[Lambda][[\[Nu]]],{\[Mu],1,d},{\[Nu],1,d}];
(* Overscript[x, .]^\[Mu] = g^\[Mu]\[Nu]Subscript[p, \[Nu]] *)
coo\[Lambda]Eqn=(D[coo\[Lambda][[#]],a\[Lambda]]==Sum[g\[Mu]\[Nu][[#,\[Nu]]]p\[Lambda][[\[Nu]]],{\[Nu],1,d}])&/@Range[1,d];
(* Subscript[Overscript[p, .], \[Mu]] = - \[PartialD]H/\[PartialD]x^\[Mu] = -(1/2)\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]
\*SuperscriptBox[\(g\), \(\[Alpha]\[Beta]\)]\) Subscript[p, \[Alpha]] Subscript[p, \[Beta]] *)
p\[Lambda]Eqn=(D[p\[Lambda][[#]],a\[Lambda]]==-D[H\[Lambda],coo\[Lambda][[#]]])&/@Range[1,d];
(* output: Hamiltonian, {xdot eqns, pdot eqns} *)
{H\[Lambda],Join[coo\[Lambda]Eqn,p\[Lambda]Eqn]}
];


(* ::Subsection::Closed:: *)
(*LieDerivative*)


(* ::Text:: *)
(*LieDerivative takes the Lie Derivative of a tensor along a vector field \[Xi].*)
(*Right now, it only takes the Lie Derivative of a metric: Subscript[(Subscript[\[Sterling], \[Xi]] g), \[Mu]\[Nu]]*)


(* ::Input::Initialization:: *)
LieDerivative[\[Xi]_Tensor,m_Tensor]/;CheckMetricTensor[m]&&(Dimensions[TensorComponents[\[Xi]]]==={Length[Coordinates[\[Xi]]]}==={Length[Coordinates[m]]})&&(Cases[\[Xi],(StartIndex->mmm_):>mmm,\[Infinity]][[1]]===Cases[m,(StartIndex->mmm_):>mmm,\[Infinity]][[1]])&&((* either both upper or lower indices *)Times@@(Sgn[#]&/@Indices[m])===1):=Module[
{Vec,\[Alpha],\[Mu],\[Nu],pd\[Xi],pdg,g\[Mu]\[Nu],g\[Mu]\[Nu]T,L1,L2,temp},
(* make sure we have a vector *)
Vec=RaiseAllIndices[\[Xi],m];
(* make sure we lowered the indices on g *)
g\[Mu]\[Nu]=Metric[SubMinus[\[Mu]],SubMinus[\[Nu]],m];
g\[Mu]\[Nu]T=TensorComponents[g\[Mu]\[Nu]];
(* Construct Partial Derivative of \[Xi] *)
pd\[Xi]=TensorComponents[PartialD[SubMinus[\[Mu]],Vec,m]];
(* Construct Partial Derivative of Subscript[g, \[Mu]\[Nu]] *)
pdg=TensorComponents[PartialD[SubMinus[\[Alpha]],g\[Mu]\[Nu],m]];
(* \[Xi]^\[Sigma]\!\(
\*SubscriptBox[\(\[PartialD]\), \(\[Sigma]\)]
\*SubscriptBox[\(g\), \(\[Mu]\[Nu]\)]\) *)
L1=TensorContract[TensorProduct[TensorComponents[Vec],pdg],{{1,2}}];
(* \!\(
\*SubscriptBox[\(\[PartialD]\), \({\[Mu]\)]
\*SuperscriptBox[\(\[Xi]\), \(\[Sigma]\)]\)Subscript[g, \[Nu]}\[Sigma]] *)
L2=TensorContract[TensorProduct[pd\[Xi],g\[Mu]\[Nu]T],{{2,4}}];
(* ... remember to symmetrize *)
L2=Transpose[L2]+L2;
temp=Tensor[
TensorType->"LieDerivative",
TensorName->Row[{"\[Sterling]",Column[{Null,Cases[\[Xi],(TensorName->mmm_):>mmm,\[Infinity]][[1]]}],Cases[m,(TensorName->mmm_):>mmm,\[Infinity]][[1]]}],
Indices->Indices[g\[Mu]\[Nu]],
StartIndex->Cases[\[Xi],(StartIndex->mmm_):>mmm,\[Infinity]][[1]],
CoordinateSystem->Coordinates[\[Xi]],
TensorComponents->L1+L2];
MoveIndices[temp,Indices[m],m]
];


(* ::Subsection:: *)
(*Ideal Magnetohydrodynamics (iMHD) in 4D*)


(* ::Subsubsection::Closed:: *)
(*Description (Reference only, no code)*)


(* ::Text:: *)
(*The primary goal of these functions in TensoriaCalc pre-pended with "MHD" is to implement the partial differential equations (PDEs) of ideal magnetohydrodynamics (MHD) in a user-specified 4-dimensional (4D) curved spacetime. *)


(* ::Text:: *)
(*"Frozen-in" condition	Ideal MHD describes Maxwell's equations coupled to an electromagnetic-current-carrying perfect fluid plasma, in such a way that the latter's number density current n^\[Mu] is always orthogonal to the electromagnetic field strength Subscript[F, \[Mu]\[Nu]], i.e., n^\[Mu] Subscript[F, \[Mu]\[Nu]]=0.*)


(* ::Text:: *)
(*Fields		The fundamental degrees of freedom in 4D MHD are 3 scalar fields, which we will denote here as {\[CapitalPhi]^I= Subscript[\[CapitalPhi], I],I=1,2,3}.*)


(* ::Text:: *)
(*From the first two scalar fields, we build the electromagnetic tensor from the wedge product of their associated 1-forms: F = \[DifferentialD]\[CapitalPhi]^1\[Wedge] \[DifferentialD]\[CapitalPhi]^2, or in components,*)
(*	 Subscript[F, \[Mu]\[Nu]] = \!\(\*SubscriptBox[\(\[PartialD]\), \(\([\)\(\[Mu]\)\)]\)\[CapitalPhi]^1Subscript[\[PartialD], \[Nu]]](\[CapitalPhi]^2)\[Congruent] \!\( *)
(*\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]*)
(*\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\)\!\( *)
(*\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]*)
(*\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\)-\!\( *)
(*\*SubscriptBox[\(\[PartialD]\), \(\[Nu]\)]*)
(*\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\)\!\( *)
(*\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]*)
(*\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\).*)


(* ::Text:: *)
(*The third scalar field enters in the plasma current,*)
(*	n^\[Mu]=\!\(\*OverscriptBox[\(\[Epsilon]\), \(~\)]\)^(\[Mu] \[Alpha]\[Beta]\[Gamma])\!\( *)
(*\*SubscriptBox[\(\[PartialD]\), \(\[Alpha]\)]*)
(*\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\)\!\( *)
(*\*SubscriptBox[\(\[PartialD]\), \(\[Beta]\)]*)
(*\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\)\!\( *)
(*\*SubscriptBox[\(\[PartialD]\), \(\[Gamma]\)]*)
(*\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\).*)
(*Because of the anti-symmetric properties of the covariant Levi-Civita tensor \!\(\*OverscriptBox[\(\[Epsilon]\), \(~\)]\)^(\[Mu] \[Alpha]\[Beta]\[Gamma]), we can see directly that n^\[Mu] \!\( *)
(*\*SubscriptBox[\(\[PartialD]\), \(\[Mu]\)]*)
(*\*SuperscriptBox[\(\[CapitalPhi]\), \(I\)]\)=0, and hence n^\[Mu] Subscript[F, \[Mu]\[Nu]]=0, as already advertised.*)


(* ::Text:: *)
(*Action	The action for MHD is*)
(*	Subscript[S, MHD] \[Congruent] \[Integral]\[DifferentialD]^4x(|g|)^(1/2)(-Subscript[\[Rho], 0][Subscript[\[Sigma], g]n^2/2]-1/4 Subscript[F, \[Mu]\[Nu]] F^\[Mu]\[Nu]), 	(Eq. 0)*)
(*where Subscript[\[Rho], 0] depends on spacetime solely through the plasma current squared (n^2) \[Congruent] Subscript[n, \[Mu]] n^\[Mu]; the *)
(*	Subscript[\[Sigma], g]=+1 	if you use Subscript[\[Eta], \[Mu]\[Nu]]=diag[+1,-1,-1,-1], 	and *)
(*	Subscript[\[Sigma], g]=-1 		if you use Subscript[\[Eta], \[Mu]\[Nu]]=diag[-1,-1,-1,-1]. *)


(* ::Text:: *)
(*See https://arxiv.org/abs/1410.5843 and http://arxiv.org/abs/1412.3135 for a discussion of Subscript[S, MHD] as a special case of string fluids. The -Subscript[\[Rho], 0] describes the plasma and the -(1/4) F^2 portion is the Maxwell action. Note that, by allowing Subscript[\[Rho], 0] to depend on spacetime solely through n^2, we are not taking into account the additional conserved charges that might be present; for a field theoretic discussion; see, for e.g., arXiv: 1107.0731.*)


(* ::Text:: *)
(*iMHD Equations.	If we first define *)
(*	P^\[Alpha]\[Beta]\[Congruent]\!\( *)
(*\*SubscriptBox[\(\[Del]\), \(\[Sigma]\)]\(( *)
(*\*SubscriptBox[\(\[Sigma]\), \(g\)] \( *)
(*\*SubscriptBox[\(\[Rho]\), \(0\)]'\)[*)
(*\*SubscriptBox[\(\[Sigma]\), \(g\)] *)
(*\*SuperscriptBox[\(n\), \(2\)]/2]\ *)
(*\*SuperscriptBox[\(\[Del]\), \(\([\)\(\[Sigma]\)\)]*)
(*\*SubscriptBox[\(\[CapitalPhi]\), \(1\)]\ *)
(*\*SuperscriptBox[\(\[Del]\), \(\[Alpha]\)]*)
(*\*SubscriptBox[\(\[CapitalPhi]\), \(2\)]\ *)
(*\*SuperscriptBox[\(\[Del]\), \(\(\[Beta]\)\(]\)\)]*)
(*\*SubscriptBox[\(\[CapitalPhi]\), \(3\)])\)\),*)
(*the Maxwell's equations part of MHD are*)
(*	\!\( *)
(*\*SubscriptBox[\(\[Del]\), \(\[Sigma]\)]*)
(*\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\)\!\( *)
(*\*SubscriptBox[\(\[Del]\), \(\[Mu]\)]*)
(*\*SuperscriptBox[\(F\), \(\[Mu]\[Sigma]\)]\)=\!\( *)
(*\*SubscriptBox[\(\[Del]\), \(\[Alpha]\)]*)
(*\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\)\!\( *)
(*\*SubscriptBox[\(\[Del]\), \(\[Beta]\)]*)
(*\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\) P^\[Alpha]\[Beta]	(Eq. 1)*)
(*	\!\( *)
(*\*SubscriptBox[\(\[Del]\), \(\[Sigma]\)]*)
(*\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\)\!\( *)
(*\*SubscriptBox[\(\[Del]\), \(\[Mu]\)]*)
(*\*SuperscriptBox[\(F\), \(\[Mu]\[Sigma]\)]\)=\!\( *)
(*\*SubscriptBox[\(\[Del]\), \(\[Alpha]\)]*)
(*\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\)\!\( *)
(*\*SubscriptBox[\(\[Del]\), \(\[Beta]\)]*)
(*\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\) P^\[Alpha]\[Beta]	(Eq. 2)*)
(*while the plasma portion of MHD reads*)
(*	0 = Subscript[F, \[Alpha]\[Beta]] P^\[Alpha]\[Beta]				(Eq. 3)*)


(* ::Text:: *)
(*Note that, Force-Free-Electrodynamics (FFE) *)
(*	\[Del]^\[Sigma]Subscript[T[EM], \[Sigma]\[Alpha]] = Subscript[\[Sigma], g]\!\( *)
(*\*SubscriptBox[\(\[Del]\), \(\[Mu]\)]*)
(*\*SuperscriptBox[\(F\), \(\[Mu]\[Sigma]\)]\) Subscript[F, \[Sigma]\[Alpha]],		\!\( *)
(*\*SubscriptBox[\(\[Del]\), \(\([\)\(\[Alpha]\)\)]*)
(*\*SubscriptBox[\(F\), \(\(\[Beta]\[Gamma]\)\(]\)\)]\)=0,*)
(*(i.e., where the electromagnetic current becomes orthogonal to the Maxwell tensor) is the limit where Eq. 3 is neglected and the right-hand-sides of Eq. 1 and Eq. 2 are set to zero.*)


(* ::Text:: *)
(*Credit		If you use MHDSystem for scientific research, please cite the URL http://www.stargazing.net/yizen/MHD.html; and the paper at http://arxiv.org/abs/1605.08786, during the course of which MHDSystem was developed.*)


(* ::Subsubsection::Closed:: *)
(*MHDSystem*)


(* ::Input::Initialization:: *)
MHDSystem[{ph1_,ph2_,ph3_},rho_Function,gBH_Tensor,OptionsPattern[]]/;CheckMetricTensor[gBH]:=Module[{MHDRules,\[Rho]0,nT,q123,n,\[Alpha]1,\[Alpha]2,\[Alpha]3,\[Zeta],F\[Mu]\[Nu],F\[Mu]\[Nu]T,LHS1,LHS2,RHS1,RHS2,RHS3,\[CapitalPhi]1,\[CapitalPhi]2,\[CapitalPhi]3,x0,x1,x2,x3,si,\[Sigma],\[Rho],\[Alpha],\[Beta],\[Gamma],X,Y,Z,\[Mu],\[Nu],\[Beta]1,\[Gamma]1,q123T,q1,q2,q3,q1T,q2T,q3T,\[Rho]0q123T,\[Rho]0q123,P,PT,divF,divFT,F2,MaxwellT,PlasmaT,coords,Opr,gsgn,TotalT},
(* metric signature converted to sign of eta_00 *)
gsgn=Which[
(OptionValue[MetricSignature]==="Mostly minus"),1,
(OptionValue[MetricSignature]==="Mostly plus"),-1
];
(* gradients of X Y Z *)
coords=Coordinates[UniqueIndices[gBH]];
(* Replacement rules *)
MHDRules={
\[CapitalPhi]1->Function[Evaluate[coords],ph1],
\[CapitalPhi]2->Function[Evaluate[coords],ph2],
\[CapitalPhi]3->Function[Evaluate[coords],ph3],
\[Rho]0->rho};
(* Opr acts on output *)
Opr=OptionValue[MHDOperator];
si=Cases[gBH,(StartIndex->xx_):>xx,\[Infinity]][[1]];
q1T[\[Sigma]_]=Tensor[
TensorType->"Gradient",
TensorName ->Del["\!\(\*SubscriptBox[\(\[CapitalPhi]\), \(1\)]\)"],
Indices->{SubMinus[\[Sigma]]},
StartIndex->si,
TensorComponents->((D[\[CapitalPhi]1[Sequence@@coords],#]&/@coords)/.MHDRules),
CoordinateSystem->coords];
q1[\[Rho]_]:=MoveIndices[q1T[\[Alpha]],{\[Rho]},UniqueIndices[gBH]];
q2T[\[Sigma]_]=Tensor[
TensorType->"Gradient",
TensorName ->Del["\!\(\*SubscriptBox[\(\[CapitalPhi]\), \(2\)]\)"],
Indices->{SubMinus[\[Sigma]]},
StartIndex->si,
TensorComponents->((D[\[CapitalPhi]2[Sequence@@coords],#]&/@coords)/.MHDRules),
CoordinateSystem->coords];
q2[\[Rho]_]:=MoveIndices[q2T[\[Sigma]],{\[Rho]},UniqueIndices[gBH]];
q3T[\[Sigma]_]=Tensor[
TensorType->"Gradient",
TensorName ->Del["\!\(\*SubscriptBox[\(\[CapitalPhi]\), \(3\)]\)"],
Indices->{SubMinus[\[Sigma]]},
StartIndex->si,
TensorComponents->((D[\[CapitalPhi]3[Sequence@@coords],#]&/@coords)/.MHDRules),
CoordinateSystem->coords];
q3[\[Rho]_]:=MoveIndices[q3T[\[Sigma]],{\[Rho]},UniqueIndices[gBH]];
(* Maxwell tensor and its divergence *)
F\[Mu]\[Nu]T[\[Sigma]_,\[Rho]_]=Tensor[
TensorType->"Maxwell",
TensorName ->"\!\(\*
StyleBox[\"F\",\nFontSlant->\"Italic\"]\)",
Indices->{SubMinus[\[Sigma]],SubMinus[\[Rho]]},
StartIndex->si,
TensorComponents->Normal[TensorWedge[TensorComponents[q1[SubMinus[\[Alpha]]]],TensorComponents[q2[SubMinus[\[Beta]]]]]],
CoordinateSystem->coords];
F\[Mu]\[Nu][\[Alpha]_,\[Beta]_]:=MoveIndices[F\[Mu]\[Nu]T[\[Sigma],\[Rho]],{\[Alpha],\[Beta]},UniqueIndices[gBH]];
(* maxwell stress tensor *)
F2=TensorContract[TensorProduct[TensorComponents[F\[Mu]\[Nu][SubMinus[\[Alpha]],SubMinus[\[Beta]]]],TensorComponents[F\[Mu]\[Nu][SuperMinus[\[Alpha]],SuperMinus[\[Beta]]]]],{{1,3},{2,4}}];
F2=Opr[gsgn(-TensorContract[TensorProduct[TensorComponents[F\[Mu]\[Nu][SubMinus[\[Alpha]],SubMinus[\[Beta]]]],TensorComponents[F\[Mu]\[Nu][SubMinus[\[Alpha]],SuperMinus[\[Beta]]]]],{{2,4}}]+1/4 TensorComponents[Metric[SubMinus[\[Alpha]],SubMinus[\[Beta]],gBH]]F2)];
MaxwellT[\[Sigma]_,\[Rho]_]=Tensor[
TensorType->"MHDMaxwell",
TensorName ->"\!\(\*
StyleBox[\"T\",\nFontSlant->\"Italic\"]\)[EM]",
Indices->{SubMinus[\[Sigma]],SubMinus[\[Rho]]},
StartIndex->si,
TensorComponents->F2,
CoordinateSystem->coords];
(* dX \[Wedge] dY \[Wedge] dZ *)
q123T[\[Alpha]1_,\[Alpha]2_,\[Alpha]3_]=Tensor[
TensorType->"3-Form",
TensorName ->OverTilde["\!\(\*
StyleBox[\"n\",\nFontSlant->\"Italic\"]\)"],
Indices->{SubMinus[\[Alpha]1],SubMinus[\[Alpha]2],SubMinus[\[Alpha]3]},
StartIndex->si,
TensorComponents->Normal[TensorWedge[TensorComponents[q1[SubMinus[\[Beta]]]],TensorComponents[q2[SubMinus[\[Beta]]]],TensorComponents[q3[SubMinus[\[Beta]]]]]],
CoordinateSystem->coords];
q123[\[Alpha]_,\[Beta]_,\[Gamma]_]:=Module[{\[Mu]1,\[Mu]2,\[Mu]3},MoveIndices[q123T[\[Mu]1,\[Mu]2,\[Mu]3],{\[Alpha],\[Beta],\[Gamma]},UniqueIndices[gBH]]];
(* Plasma current *)
nT[\[Mu]_]=((CovariantHodgeDual[SuperMinus[\[Mu]],q123[SubMinus[\[Alpha]],SubMinus[\[Beta]],SubMinus[\[Gamma]]],UniqueIndices[gBH]]//Opr)/.(TensorName->name_)->(TensorName->"\!\(\*
StyleBox[\"n\",\nFontSlant->\"Italic\"]\)"));
n[\[Mu]_]:=MoveIndices[nT[\[Sigma]],{\[Mu]},UniqueIndices[gBH]];
(* Construct P^\[Beta]\[Gamma] in the notes *)
\[Rho]0q123T[\[Alpha]_,\[Beta]_,\[Gamma]_]=Tensor[
TensorType->"3-Form",
TensorName ->"\!\(\*
StyleBox[\"P\",\nFontSlant->\"Italic\"]\)",
Indices->{SuperMinus[\[Alpha]],SuperMinus[\[Beta]],SuperMinus[\[Gamma]]},
StartIndex->si,
TensorComponents->Opr[((gsgn \[Rho]0'[(1/2)gsgn TensorComponents[n[SubMinus[\[Sigma]]]] . TensorComponents[n[SuperMinus[\[Sigma]]]]])/.MHDRules)]TensorComponents[q123[SuperMinus[\[Alpha]1],SuperMinus[\[Beta]1],SuperMinus[\[Gamma]1]]],
CoordinateSystem->coords];
\[Rho]0q123[\[Alpha]_,\[Beta]_,\[Gamma]_]:=MoveIndices[\[Rho]0q123T[\[Alpha]1,\[Alpha]2,\[Alpha]3],{\[Alpha],\[Beta],\[Gamma]},UniqueIndices[gBH]];
PT[\[Beta]_,\[Gamma]_]=Tensor[
TensorType->"2-Form",
TensorName ->"\!\(\*
StyleBox[\"P\",\nFontSlant->\"Italic\"]\)",
Indices->{SuperMinus[\[Beta]],SuperMinus[\[Gamma]]},
StartIndex->si,
TensorComponents->TensorComponents[CovariantD[SubMinus[\[Sigma]],\[Rho]0q123[SuperMinus[\[Sigma]],SuperMinus[\[Beta]1],SuperMinus[\[Gamma]1]],UniqueIndices[gBH]]],
CoordinateSystem->coords];
P[\[Beta]_,\[Gamma]_]:=MoveIndices[Opr[PT[\[Alpha]1,\[Alpha]2]],{\[Beta],\[Gamma]},UniqueIndices[gBH]];
(* perfect fluid stress tensor of plasma *)
F2=Opr[TensorComponents[n[SubMinus[\[Sigma]]]] . TensorComponents[n[SuperMinus[\[Sigma]]]]];
F2=(gsgn TensorComponents[Metric[SuperMinus[\[Alpha]],SuperMinus[\[Beta]],UniqueIndices[gBH]]](\[Rho]0[gsgn F2/2]-\[Rho]0'[gsgn F2/2]gsgn F2)+\[Rho]0'[gsgn F2/2]TensorProduct[TensorComponents[n[SuperMinus[\[Mu]]]],TensorComponents[n[SuperMinus[\[Nu]]]]])/.MHDRules;
PlasmaT[\[Sigma]_,\[Rho]_]=Tensor[
TensorType->"MHDPlasma",
TensorName ->"\!\(\*
StyleBox[\"T\",\nFontSlant->\"Italic\"]\)[Plasma]",
Indices->{SuperMinus[\[Sigma]],SuperMinus[\[Rho]]},
StartIndex->si,
TensorComponents->Opr[F2],
CoordinateSystem->coords];
(* total stress tensor *)
TotalT[\[Sigma]_,\[Rho]_]=Tensor[
TensorType->"MHDMaxwellPlasma",
TensorName ->"\!\(\*
StyleBox[\"T\",\nFontSlant->\"Italic\"]\)[Total]",
Indices->{SuperMinus[\[Sigma]],SuperMinus[\[Rho]]},
StartIndex->si,
(* remember we defined photon T\[Mu]\[Nu] with both lower indices and plasma with both upper *)
TensorComponents->TensorComponents[RaiseAllIndices[MaxwellT[\[Mu],\[Nu]],UniqueIndices[gBH]]]+TensorComponents[PlasmaT[\[Mu],\[Nu]]],
CoordinateSystem->coords];
(* EM current *)
divFT[\[Mu]_]=Tensor[
TensorType->"MaxwellCurrent",
TensorName ->"\!\(\*
StyleBox[\"J\",\nFontSlant->\"Italic\"]\)",
Indices->{SubMinus[\[Mu]]},
StartIndex->si,
TensorComponents->(TensorComponents[CovariantD[SuperMinus[\[Sigma]],F\[Mu]\[Nu][SubMinus[\[Sigma]],SubMinus[\[Rho]]],UniqueIndices[gBH]]]//Opr),
CoordinateSystem->coords];
divF[\[Rho]_]:=MoveIndices[divFT[\[Alpha]],{\[Rho]},UniqueIndices[gBH]];
(* EOM I : \!\(
\*SubscriptBox[\(\[Del]\), \(\[Sigma]\)]\[Zeta]\) \!\(
\*SubscriptBox[\(\[Del]\), \(\[Mu]\)]
\*SuperscriptBox[\(F\), \(\[Mu]\[Sigma]\)]\) = Subscript[q1, \[Alpha]] Subscript[q3, \[Beta]] P^\[Alpha]\[Beta] *)
LHS1=((TensorComponents[q1[SubMinus[\[Sigma]]]] . TensorComponents[divF[SuperMinus[\[Rho]]]])//Opr);
RHS1=Opr[TensorContract[TensorProduct[TensorComponents[q1[SubMinus[\[Sigma]]]],TensorComponents[q3[SubMinus[\[Sigma]]]],TensorComponents[P[SuperMinus[\[Sigma]],SuperMinus[\[Rho]]]]],{{1,3},{2,4}}]];
(* EOM II : \!\(
\*SubscriptBox[\(\[Del]\), \(\[Sigma]\)]Y\) \!\(
\*SubscriptBox[\(\[Del]\), \(\[Mu]\)]
\*SuperscriptBox[\(F\), \(\[Mu]\[Sigma]\)]\) = Subscript[q2, \[Alpha]] Subscript[q3, \[Beta]] P^\[Alpha]\[Beta] *)
LHS2=(TensorComponents[q2[SubMinus[\[Sigma]]]] . TensorComponents[divF[SuperMinus[\[Rho]]]])//Opr;
RHS2=Opr[TensorContract[TensorProduct[TensorComponents[q2[SubMinus[\[Sigma]]]],TensorComponents[q3[SubMinus[\[Sigma]]]],TensorComponents[P[SuperMinus[\[Sigma]],SuperMinus[\[Rho]]]]],{{1,3},{2,4}}]];
(* EOM III : 0 = Subscript[q2, \[Alpha]] Subscript[q3, \[Beta]] P^\[Alpha]\[Beta] *)
RHS3=Opr[TensorContract[TensorProduct[TensorComponents[F\[Mu]\[Nu][SubMinus[\[Sigma]],SubMinus[\[Rho]]]],TensorComponents[P[SuperMinus[\[Sigma]],SuperMinus[\[Rho]]]]],{{1,3},{2,4}}]];
(* output *)
MHDSystem[
(* 3 scalars *)
MHDScalarFunction1->ph1,
MHDScalarFunction2->ph2,
MHDScalarFunction3->ph3,
MHD1FormTensor1->(q1T[Unique[\[Sigma]]]),
MHD1FormTensor2->(q2T[Unique[\[Sigma]]]),
MHD1FormTensor3->(q3T[Unique[\[Sigma]]]),
MHD3FormTensor->(q123T[Unique[\[Alpha]1],Unique[\[Alpha]2],Unique[\[Alpha]3]]),
MHDMaxwellTensor->(F\[Mu]\[Nu]T[Unique[\[Sigma]],Unique[\[Rho]]]),
MHDPlasmaCurrentTensor->(nT[Unique[\[Mu]]]),
MHDRank2PTensor->(PT[Unique[\[Beta]],Unique[\[Gamma]]]),
MHDMaxwellCurrentTensor->(divFT[Unique[\[Rho]]]),
MHDEquationsList->({(* eq 1: {LHS,RHS} *){LHS1,RHS1},(* eq 2: {LHS,RHS} *){LHS2,RHS2},(* eq 3: {LHS=0,RHS} *){0,RHS3}}),
(* stress tensors *)
MHDMaxwellStressTensor->(MaxwellT[Unique[\[Sigma]],Unique[\[Rho]]]),
MHDPlasmaStressTensor->(PlasmaT[Unique[\[Sigma]],Unique[\[Rho]]]),
MHDTotalStressTensor->TotalT[Unique[\[Sigma]],Unique[\[Rho]]],
MHDPlasmaEnergyDensityOperator->rho,
(* MHD Lagrangian -\[Rho]0-(1/4)F^2 *)
MHDLagrangianDensity->-(\[Rho]0[(1/2)gsgn (TensorComponents[n[SubMinus[\[Sigma]]]] . TensorComponents[n[SuperMinus[\[Sigma]]]])//Opr]/.MHDRules)-(1/4)TensorContract[TensorProduct[TensorComponents[F\[Mu]\[Nu][SubMinus[Unique[\[Sigma]]],SubMinus[Unique[\[Rho]]]]],TensorComponents[F\[Mu]\[Nu][SuperMinus[Unique[\[Sigma]]],SuperMinus[Unique[\[Rho]]]]]],{{1,3},{2,4}}],
(* store metric info too *)
MHDMetricTensor->UniqueIndices[gBH],
CoordinateSystem->Coordinates[UniqueIndices[gBH]],
MetricSignature->OptionValue[MetricSignature]
]]/;((OptionValue[MetricSignature]==="Mostly minus")||(OptionValue[MetricSignature]==="Mostly plus"));


(* ::Input::Initialization:: *)
(* Appearance of MHDSystem *)
MHDSystem/:Format[MHDSystem[
xxx___,
MHDScalarFunction1->ph1_,
MHDScalarFunction2->ph2_,
MHDScalarFunction3->ph3_,
MetricSignature->ss_,
MHDPlasmaEnergyDensityOperator->rho_,
MHDMetricTensor->ggg_
]]:=Module[{sg},
(* metric signature *)
sg=Which[ss==="Mostly minus","+",ss==="Mostly plus","-"];
MHDSystem[MatrixForm[
{(* {ph1,ph2,ph3,"n^\[Mu]"\[Rule]TensorComponents[nnnT]},
{"Subscript[F, \[Mu]\[Nu]]"\[Rule]MatrixForm[TensorComponents[F\[Mu]\[Nu]TT]],"J^\[Mu]"\[Rule]TensorComponents[MaxJTT]},
{"T[EMSubscript[], \[Mu]\[Nu]]"\[Rule]MatrixForm[TensorComponents[MaxTT]],"T[PlasmaSubscript[], \[Mu]\[Nu]]"\[Rule]MatrixForm[TensorComponents[PlasmaTT]]}, *)
"Ideal MHD/Maxwell's equation 1: \!\(\*SubscriptBox[\(\[Del]\), \(\[Sigma]\)]\)\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\) \!\(\*SubscriptBox[\(\[Del]\), \(\[Mu]\)]\)\!\(\*SuperscriptBox[
StyleBox[\"F\",\nFontSlant->\"Italic\"], \(\[Mu]\[Sigma]\)]\) = \!\(\*SubscriptBox[\(\[Del]\), \(\[Alpha]\)]\)\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\) \!\(\*SubscriptBox[\(\[Del]\), \(\[Beta]\)]\)\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\) \!\(\*SuperscriptBox[
StyleBox[\"P\",\nFontSlant->\"Italic\"], \(\[Alpha]\[Beta]\)]\)",
"Ideal MHD/Maxwell's equation 2: \!\(\*SubscriptBox[\(\[Del]\), \(\[Sigma]\)]\)\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\) \!\(\*SubscriptBox[\(\[Del]\), \(\[Mu]\)]\)\!\(\*SuperscriptBox[
StyleBox[\"F\",\nFontSlant->\"Italic\"], \(\[Mu]\[Sigma]\)]\) = \!\(\*SubscriptBox[\(\[Del]\), \(\[Alpha]\)]\)\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\) \!\(\*SubscriptBox[\(\[Del]\), \(\[Beta]\)]\)\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\) \!\(\*SuperscriptBox[
StyleBox[\"P\",\nFontSlant->\"Italic\"], \(\[Alpha]\[Beta]\)]\)",
"Ideal MHD/Plasma equation: 0 = \!\(\*SubscriptBox[
StyleBox[\"F\",\nFontSlant->\"Italic\"], \(\[Alpha]\[Beta]\)]\) \!\(\*SuperscriptBox[
StyleBox[\"P\",\nFontSlant->\"Italic\"], \(\[Alpha]\[Beta]\)]\)",
"With \!\(\*SuperscriptBox[
StyleBox[\"P\",\nFontSlant->\"Italic\"], \(\[Alpha]\[Beta]\)]\) \[Congruent] "<>sg<>"\!\(\*SubscriptBox[\(\[Del]\), \(\[Sigma]\)]\)\!\(\*
StyleBox[\"(\",\nFontSize->16]\)\!\(\*SubscriptBox[\(\[Rho]\), \(0\)]\)["<>sg<>"\!\(\*SuperscriptBox[
StyleBox[\"n\",\nFontSlant->\"Italic\"], \(2\)]\)/2] \!\(\*SuperscriptBox[\(\[Del]\), \([\[Sigma]\)]\)\!\(\*SubscriptBox[\(\[CapitalPhi]\), \(1\)]\)\!\(\*SuperscriptBox[\(\[Del]\), \(\[Alpha]\)]\)\!\(\*SubscriptBox[\(\[CapitalPhi]\), \(2\)]\)\!\(\*SuperscriptBox[\(\[Del]\), \(\(\[Beta]\)\(]\)\)]\)\!\(\*SubscriptBox[\(\[CapitalPhi]\), \(3\)]\)\!\(\*
StyleBox[\")\",\nFontSize->16]\)",
Row[{"Scalar fields : ",MatrixForm[{"\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(1\)]\)"->ph1,"\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(2\)]\)"->ph2,"\!\(\*SuperscriptBox[\(\[CapitalPhi]\), \(3\)]\)"->ph3}]}],
Row[{"Plasma energy density : "," \!\(\*SubscriptBox[\(\[Rho]\), \(0\)]\)["<>sg<>"\!\(\*SuperscriptBox[
StyleBox[\"n\",\nFontSlant->\"Italic\"], \(2\)]\)/2]"->rho[sg<>"\!\(\*
StyleBox[SuperscriptBox[
StyleBox[\"n\",\nFontSlant->\"Italic\"], \"2\"],\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\"/\",\nFontSlant->\"Italic\"]\)\!\(\*
StyleBox[\"2\",\nFontSlant->\"Italic\"]\)"]}],
{"\!\(\*SubscriptBox[\(g\), \(\[Mu]\[Nu]\)]\)"->MatrixForm[TensorComponents[ggg]],Coordinates->Coordinates[ggg]}}]]];


(* ::Input::Initialization:: *)
(* old code *)
(* MHDSystem/:Format[MHDSystem[
xxx___,
MHDScalar1\[Rule]ph1_,
MHDScalar2\[Rule]ph2_,
MHDScalar3\[Rule]ph3_,
MHDMaxwellTensor\[Rule]F\[Mu]\[Nu]TT_,
MHDMaxwellStressTensor\[Rule]MaxTT_,
MHDMaxwellCurrentTensor\[Rule]MaxJTT_,
MHDPlasmaStressTensor\[Rule]PlasmaTT_,
MHDEquationsList\[Rule]{{l1_,r1_},{l2_,r2_},{0,r3_}},
MHDPlasmaCurrentTensor\[Rule]nnnT_,
MHDMetricTensor\[Rule]ggg_
]]:=MHDSystem[MatrixForm[
{(* {ph1,ph2,ph3,"n^\[Mu]"\[Rule]TensorComponents[nnnT]},
{"Subscript[F, \[Mu]\[Nu]]"\[Rule]MatrixForm[TensorComponents[F\[Mu]\[Nu]TT]],"J^\[Mu]"\[Rule]TensorComponents[MaxJTT]},
{"T[EMSubscript[], \[Mu]\[Nu]]"\[Rule]MatrixForm[TensorComponents[MaxTT]],"T[PlasmaSubscript[], \[Mu]\[Nu]]"\[Rule]MatrixForm[TensorComponents[PlasmaTT]]}, *)
{MatrixForm[{"Ideal MHD/Maxwell's equation 1: Subscript[\[Del], \[Sigma]]\[CapitalPhi]^1 Subscript[\[Del], \[Mu]]F^\[Mu]\[Sigma] = Subscript[\[Del], \[Alpha]]\[CapitalPhi]^1 Subscript[\[Del], \[Beta]]\[CapitalPhi]^3 P^\[Alpha]\[Beta]",l1==r1}]},{MatrixForm[{"Ideal MHD/Maxwell's equation 2: Subscript[\[Del], \[Sigma]]\[CapitalPhi]^2 Subscript[\[Del], \[Mu]]F^\[Mu]\[Sigma] = Subscript[\[Del], \[Alpha]]\[CapitalPhi]^2 Subscript[\[Del], \[Beta]]\[CapitalPhi]^3 P^\[Alpha]\[Beta]",l2==r2}]},
{MatrixForm[{"Ideal MHD/Plasma equation: 0 = Subscript[F, \[Alpha]\[Beta]] P^\[Alpha]\[Beta]",0==r3}]},
{"Subscript[g, \[Mu]\[Nu]]"\[Rule]MatrixForm[TensorComponents[ggg]],Coordinates\[Rule]Coordinates[ggg]}}]]; *)


(* ::Subsubsection::Closed:: *)
(*MHDScalar*)


(* ::Input::Initialization:: *)
(* scalars *)
MHDScalar[1,mm_MHDSystem]:=Module[{xx},Cases[mm,(MHDScalarFunction1->xx_):>xx,\[Infinity]][[1]]];
MHDScalar[2,mm_MHDSystem]:=Module[{xx},Cases[mm,(MHDScalarFunction2->xx_):>xx,\[Infinity]][[1]]];
MHDScalar[3,mm_MHDSystem]:=Module[{xx},Cases[mm,(MHDScalarFunction3->xx_):>xx,\[Infinity]][[1]]];
(* 1-forms/vectors *)
MHDScalar[\[Mu]T_/;CheckIndex[\[Mu]T],1,mm_MHDSystem]:=Module[{\[Alpha],xx},MoveIndices[Cases[mm,(MHD1FormTensor1->xx_):>xx,\[Infinity]][[1]],{\[Mu]T},Cases[mm,(MHDMetricTensor->xx_):>xx,\[Infinity]][[1]]]];
MHDScalar[\[Mu]T_/;CheckIndex[\[Mu]T],2,mm_MHDSystem]:=Module[{\[Alpha],xx},MoveIndices[Cases[mm,(MHD1FormTensor2->xx_):>xx,\[Infinity]][[1]],{\[Mu]T},Cases[mm,(MHDMetricTensor->xx_):>xx,\[Infinity]][[1]]]];
MHDScalar[\[Mu]T_/;CheckIndex[\[Mu]T],3,mm_MHDSystem]:=Module[{\[Alpha],xx},MoveIndices[Cases[mm,(MHD1FormTensor3->xx_):>xx,\[Infinity]][[1]],{\[Mu]T},Cases[mm,(MHDMetricTensor->xx_):>xx,\[Infinity]][[1]]]];


(* ::Subsubsection::Closed:: *)
(*MHD3Form*)


(* ::Input::Initialization:: *)
MHD3Form[\[Mu]T_/;CheckIndex[\[Mu]T],\[Nu]T_/;CheckIndex[\[Nu]T],\[Gamma]T_/;CheckIndex[\[Gamma]T],mm_MHDSystem]:=Module[{\[Alpha],\[Beta],xx},MoveIndices[Cases[mm,(MHD3FormTensor->xx_):>xx,\[Infinity]][[1]],{\[Mu]T,\[Nu]T,\[Gamma]T},Cases[mm,(MHDMetricTensor->xx_):>xx,\[Infinity]][[1]]]];


(* ::Subsubsection::Closed:: *)
(*MHDPlasmaCurrent*)


(* ::Input::Initialization:: *)
MHDPlasmaCurrent[\[Mu]T_/;CheckIndex[\[Mu]T],mm_MHDSystem]:=Module[{xx},MoveIndices[Cases[mm,(MHDPlasmaCurrentTensor->xx_):>xx,\[Infinity]][[1]],{\[Mu]T},Cases[mm,(MHDMetricTensor->xx_):>xx,\[Infinity]][[1]]]];


(* ::Subsubsection::Closed:: *)
(*MHDMaxwell*)


(* ::Input::Initialization:: *)
MHDMaxwell[\[Mu]T_/;CheckIndex[\[Mu]T],\[Nu]T_/;CheckIndex[\[Nu]T],mm_MHDSystem]:=Module[{xx},MoveIndices[Cases[mm,(MHDMaxwellTensor->xx_):>xx,\[Infinity]][[1]],{\[Mu]T,\[Nu]T},Cases[mm,(MHDMetricTensor->xx_):>xx,\[Infinity]][[1]]]];


(* ::Subsubsection::Closed:: *)
(*MHDMaxwellCurrent*)


(* ::Input::Initialization:: *)
MHDMaxwellCurrent[\[Mu]T_/;CheckIndex[\[Mu]T],mm_MHDSystem]:=Module[{xx},MoveIndices[Cases[mm,(MHDMaxwellCurrentTensor->xx_):>xx,\[Infinity]][[1]],{\[Mu]T},Cases[mm,(MHDMetricTensor->xx_):>xx,\[Infinity]][[1]]]];


(* ::Subsubsection::Closed:: *)
(*MHDRank2P*)


(* ::Input::Initialization:: *)
MHDRank2P[\[Mu]T_/;CheckIndex[\[Mu]T],\[Nu]T_/;CheckIndex[\[Nu]T],mm_MHDSystem]:=Module[{xx},MoveIndices[Cases[mm,(MHDRank2PTensor->xx_):>xx,\[Infinity]][[1]],{\[Mu]T,\[Nu]T},Cases[mm,(MHDMetricTensor->xx_):>xx,\[Infinity]][[1]]]];


(* ::Subsubsection::Closed:: *)
(*MHDEquations*)


(* ::Input::Initialization:: *)
(* remember we have ordered the eqns from left to right (eq. 1, 2, 3 in Description above) *)
MHDEquations[mm_MHDSystem]:=Module[{xx},(Equal@@#)&/@Cases[mm,(MHDEquationsList->xx_):>xx,\[Infinity]][[1]]];


(* ::Subsubsection::Closed:: *)
(*MHDEnergyMomentumShearStress*)


(* ::Input::Initialization:: *)
MHDEnergyMomentumShearStress[\[Mu]T_/;CheckIndex[\[Mu]T],\[Nu]T_/;CheckIndex[\[Nu]T],ss_String,mm_MHDSystem]/;((ss==="Maxwell")||(ss==="Photons")||(ss==="EM")||(ss==="Electromagnetic")||(ss==="Plasma")||(ss==="Total")):=Module[{xx},
Which[
(ss==="Maxwell")||(ss==="Photons")||(ss==="EM")||(ss==="Electromagnetic"),
		MoveIndices[Cases[mm,(MHDMaxwellStressTensor->xx_):>xx,\[Infinity]][[1]],{\[Mu]T,\[Nu]T},Cases[mm,(MHDMetricTensor->xx_):>xx,\[Infinity]][[1]]],
(ss==="Plasma"),
		MoveIndices[Cases[mm,(MHDPlasmaStressTensor->xx_):>xx,\[Infinity]][[1]],{\[Mu]T,\[Nu]T},Cases[mm,(MHDMetricTensor->xx_):>xx,\[Infinity]][[1]]],
(ss==="Total"),
		MoveIndices[Cases[mm,(MHDTotalStressTensor->xx_):>xx,\[Infinity]][[1]],{\[Mu]T,\[Nu]T},Cases[mm,(MHDMetricTensor->xx_):>xx,\[Infinity]][[1]]]
]];


(* ::Subsubsection::Closed:: *)
(*MHDPlasmaEnergyDensity*)


(* ::Input::Initialization:: *)
(* extract plasma energy density operator from MHDSystem *)
MHDPlasmaEnergyDensity[mm_MHDSystem]:=Module[{xx},Cases[mm,(MHDPlasmaEnergyDensityOperator->xx_):>xx,\[Infinity]][[1]]];


(* ::Subsubsection::Closed:: *)
(*MHDMetric*)


(* ::Input::Initialization:: *)
(* extract metric from MHDSystem *)
MHDMetric[\[Mu]T_/;CheckIndex[\[Mu]T],\[Nu]T_/;CheckIndex[\[Nu]T],mm_MHDSystem]:=Metric[\[Mu]T,\[Nu]T,Module[{xx},Cases[mm,(MHDMetricTensor->xx_):>xx,\[Infinity]][[1]]]];


(* ::Subsubsection::Closed:: *)
(*MHDLagrangian*)


(* ::Input::Initialization:: *)
(* extract Lagrangian density from MHDSystem *)
MHDLagrangian[mm_MHDSystem]:=Module[{xx},Cases[mm,(MHDLagrangianDensity->xx_):>xx,\[Infinity]][[1]]];


(* ::Subsubsection:: *)
(*Update History (MHD-related only)*)


(* ::Section::Closed:: *)
(*Protect*)


(* ::Input::Initialization:: *)
(* Protect these symbols so they cannot be altered *)
Protect[Del,SubMinus,SuperMinus,Tensor,TensorType,TensorName,Indices,Metric,Riemann,Weyl,Ricci,RicciScalar,Einstein,CoordinateSystem,Coordinates,TensorComponents,RiemannComponents,RicciComponents,Christoffel,RicciScalarInvariant,ChristoffelComponents,StartIndex,Determinant,MetricDeterminant,TooltipDisplay,ChristoffelOperator,RiemannOperator,RicciOperator,RicciScalarOperator,EinsteinOperator,WeylOperator,CovariantBox,CoordinateTransformation,GradientSquared,ContractTensors,CovariantD,PartialD,SwapIndices,UnderBar,TensorIsZero,NonMetricTensor,MoveIndices,LeviCivita,RaiseAllIndices,LowerAllIndices,UniqueIndices,CovariantHodgeDual,GeodesicSystem,GeodesicLagrangians,GeodesicHamiltonianDynamics,AffineParameter,NonAffineParameter,LieDerivative,MHDSystem,MHDScalarFunction1,MHDScalarFunction2,MHDScalarFunction3,MHD1FormTensor1,MHD1FormTensor2,MHD1FormTensor3,MHD3Form,MHDMaxwellTensor,MHDPlasmaCurrentTensor,MHDRank2PTensor,MHDMaxwellCurrent,MHDEquations,MHDEquationsList,MHDMetricTensor,MHDScalar,MHD3Form,MHDPlasmaCurrent,MHDMaxwell,MHDMaxwellCurrent,MHDMaxwellStressTensor,MHDPlasmaStressTensor,MHDRank2P,MHDEnergyMomentumShearStress,MHDMetric,MHDOperator,MetricSignature,MHDTotalStressTensor,MHDLagrangian,MHDLagrangianDensity,MHDPlasmaEnergyDensityOperator,MHDPlasmaEnergyDensity];


(* ::Section::Closed:: *)
(*End*)


(* ::Input::Initialization:: *)
End[];
EndPackage[];


(* ::Section::Closed:: *)
(*Update History*)


(* ::Text:: *)
(*Feb 2012: *)
(**)
(*Update: The function Metric is extended to allow the user to input a Tensor object of TensorType -> "Metric". Metric returns the same object with TensorComponents \[LongDash] depending on the input indices \[LongDash] representing either the metric, inverse metric, or the identity. In other words, TensoriaCalc now allow raising and lowering of the indices of Tensor objects of TensorType -> "Metric".*)
(*	*)
(*Update: Previously, the metric can only be entered as a List (i.e. a matrix). The function Metric is extended to allow the metric to be entered as an expression quadratic in the differentials of the coordinates. For example, {{1,0},{0,r^2}} or \[DifferentialD]r^2+r^2 \[DifferentialD]\[Phi]^2, with CoordinateSystem -> {r,\[Phi]}, are both valid ways to enter the metric of the Euclidean 2-space.*)


(* ::Text:: *)
(*March 2012*)
(**)
(*Bug fix: RaiseLower, the function within TensoriaCalc that plays a key role in raising and lowering indices of Tensor objects, now takes into account both metrics and inverse metric when reading in a Tensor object of TensorType -> "Metric". Previously it had assumed all such objects had TensorComponents with lower indices, i.e., all were metrics and not inverse metrics.*)


(* ::Text:: *)
(*May 2012*)
(*	*)
(*Update: Added section "Geometric Objects: Definitions".*)


(* ::Text:: *)
(*April 2013*)
(*	*)
(*Update! New TensoriaCalc function CovariantBox added. This is intended to be the wave operator acting on any Tensor object. Right now, however, only scalars are supported.*)
(*	*)
(*Update! New TensoriaCalc function CoordinateTransformation added. This computes the Jacobian of coordinate transformations.*)


(* ::Text:: *)
(*July 2013*)
(**)
(*Update! New TensoriaCalc function GradientSquared added. This computes (\[Del]f)^2 for any scalar function f.*)


(* ::Text:: *)
(*August 2013*)
(*	*)
(*Update: Series now allows for expansion with respect to multiple parameters. Previously, only Series[Tensor[...],{\[Epsilon],\[Epsilon]start,n}] was supported.*)
(*	*)
(*Update: Instead of the Union of the coordinate transformations CT and its associated Jacobian JC, CoordinateTransformation now outputs Flatten[{JC, CT}] instead.*)


(* ::Text:: *)
(*November 2013*)
(*	*)
(*Update: Metric[..., M, ...], where M is the matrix representation of the given geometry, now checks explicitly whether the Head[M] === List.*)
(*	*)
(*Update: CheckMetric, the function that checks whether a given expression is a quadratic form of coordinate differentials, now does so by checking that the expression scales homogeneously under \[DifferentialD]x^\[Mu]->\[Epsilon] \[DifferentialD]\!\(TraditionalForm\`\( *)
(*\*SuperscriptBox[\(x\), \(\[Mu]\)]\(\ \)\)\).*)


(* ::Text:: *)
(*December 2013*)
(*	*)
(*Update: Metric now applies FullSimplify[Inverse[#]]& to the matrix representation of Subscript[g, \[Mu]\[Nu]] to convert it to g^\[Mu]\[Nu], and similarly vice versa. Previously, to convert from Subscript[g, \[Mu]\[Nu]] to g^\[Mu]\[Nu], or vice versa, it would only apply Inverse[#]&.*)


(* ::Text:: *)
(*(April and May) 2014*)
(*	*)
(*Update: Created subsections Tensor Code and Tensor Arguments. The former contains code related to Tensor; the latter is for documentation purposes \[LongDash] we need to keep track of the range of arguments that can occur within Tensor.*)
(*	*)
(*Update! New function CovariantD[SubMinus[\[Mu]] or SuperMinus[\[Mu]], S, m_Tensor] applies Subscript[\[Del], \[Mu]] (or \[Del]^\[Mu]) on S with respect to the metric Tensor m. We assume metric compatibility.*)
(**)
(*Update! New function ContractTensors[Times[tt__Tensor]] builds a single Tensor object from the sequence tt and sums over all repeated indices.*)
(**)
(*Update! New function SwapIndices takes in a Tensor object and swaps its indices and the appropriate portions of its TensorComponents.*)
(**)
(*Update: Indices now also takes in a Tensor object and returns the RHS of its Indices->RHS.*)
(**)
(*Update: TensorComponents now also takes in a Tensor object and returns the RHS of its TensorComponents->RHS.*)


(* ::Text:: *)
(*January 2015*)
(**)
(*Update! New function Einstein[\[Mu],\[Nu],MetricTensor_Tensor,EinsteinOperator->op] computes the Einstein tensor of the metric MetricTensor and applies the operator op to it. EinsteinOperator is optional; the default is op = FullSimplify.*)
(**)
(*Update: Previously, when and only when all its indices are Integers or all of them are Coordinates, does Tensor returns the 	corresponding component. We have now updated this to allow mixed Integer/Coordinate indices, i.e., as long as non of the indices are abstract ones, TensoriaCalc will return the corresponding component of the Tensor. Also: (1) Duplicate code was deleted. (2) The condition that the Integer be >= 0 was removed. *)
(*	*)
(*Update: Previously, when and only when all its indices are Integers or all of them are Coordinates, does Tensor returns the 	corresponding component. Now, Tensor is updated such that, as long as one or more of its indices are not abstract ones, the TensorComponents would be reduced in rank accordingly, for e.g., Subscript[g, Underbar[0]\[Nu]] (constructed from the Metric) is now a vector. We Apply UnderBar to the non-abstract index as a bookkeeping device, so that TensoriaCalc will treat it as a scalar.*)
(**)
(*Update: (Internal) UpOrDown[\[Mu]_] was previously defined with CheckIndex[\[Mu]] imposed. This constraint has now been dropped.*)
(**)
(*Update: When defining the appearance of non-Metric Tensors, we previously imposed the constraint that all indices must be Symbolic ones. This constraint has now been dropped.*)
(*	*)
(*Update: Repeated indices occurring within a single Tensor are now automatically summed over. Underbar is then applied to these repeated indices for bookkeeping purposes, so that TensoriaCalc will treat them as a scalars.*)
(*	*)
(*Update: CovariantD now allows for the \[Del]-index and one of the input Tensor's index to be repeated.*)
(*	*)
(*Update! New function Weyl[\[Alpha],\[Beta],\[Mu],\[Nu],MetricTensor_Tensor,WeylOperator->op] computes the Weyl tensor of the metric MetricTensor and applies the operator op to it. WeylOperator is optional; the default is op = FullSimplify.*)
(*	*)
(*Update! New function TensorIsZero[stuff_Tensor] returns True if every component of the Tensor stuff is zero and False otherwise.*)
(**)
(*Update: (Internal) NotAbstractIndex[\[Mu]] returns True if \[Mu] is not an abstract index (\[Congruent] (SuperMinus or SubMinus)[_Symbol or _Integer]) and False otherwise.*)
(**)
(*Update: (Internal) ScalarTest[m_Tensor] returns True if the Tensor m is a scalar and False otherwise.*)
(*	*)
(*Update: (Internal) RemoveUnderBarredIndices[\[Mu]T_List] removes from the list of indices \[Mu]T all indices with UnderBar applied to them.*)
(*	*)
(*Update: (Internal) RemoveRepeatedUnderBarredIndices[\[Mu]T_List] removes from the list of indices \[Mu]T all repeated UnderBarred indices.*)
(*	*)
(*Update: (Internal) NestedDel[dd_Del] takes an expression of the form Del[...Del[stuff]] and peels off the Del's one by one until the Head of stuff is not Del. Returns {# of Del's, stuff}.*)
(**)
(*Update: "Update History" format changed slightly.*)
(**)
(*Update: Previously, TensorComponents distinguished between whether the input Tensor was a scalar or higher rank tensor. This is not necessary, and the code has been simplified.*)
(**)
(*Update: SwapIndices updated to account for the presence of UnderBarred indices.*)
(**)
(*Update: Until further notice we will not use ContractTensors in internal TensoriaCalc code, because ContractTensors is not properly developed. To this end, the CovariantD code has been modified.*)
(**)
(*Update: Sgn code simplified.*)
(**)
(*Update! New function PartialD[\[Mu],stuff_,MetricM_Tensor] returns the partial derivative of stuff using the Metric Tensor MetricM.*)
(**)
(*Bug Fix: Raising and lowering of the indices of the Ricci tensor has been de-bugged. Previously, the left index was raised/lowered instead of the right index, and vice versa. :-/*)
(**)
(*Update! New function NonMetricTensor returns a user defined Tensor object.*)
(**)
(*Update! MoveIndices[tt_Tensor,idx_List,m_Tensor] raises/lower indices of tt, as specified by the idx, using the Metric Tensor m. Suppose tt has indices {SubMinus[\[Alpha]], SuperMinus[\[Beta]] ,SuperMinus[\[Mu]], SubMinus[\[Nu]]} and \[Alpha] and \[Mu] needs to be raised and lowered respectively, then do MoveIndices[tt_Tensor,{SuperMinus[\[Alpha]],SubMinus[\[Mu]]},m].*)
(**)
(*Update: All the default settings for RiemannOperator, WeylOperator, etc. have been changed from FullSimplify to Simplify to reduce computation time.*)
(**)
(*Update: All scalar, rank 1 and rank 2 tensors \[LongDash] including Metric Tensors \[LongDash] will now be displayed as their TensorNames with appropriate indices attached (e.g., Subscript[g, \[Mu]\[Nu]]). (Previously, the Metric Tensor, in particular, was displayed with a Tensor Head with the components of the Ricci tensor/scalar, Christoffel symbols, Riemann tensor, etc., as its arguments.) Hovering the mouse cursor over these scalar, vectors and tensors will display their TensorComponents and the coordinates used.*)
(**)
(*Update: When Metric Tensor has one up and one down index, the TensorName is changed to \[Delta].*)


(* ::Text:: *)
(*February 2015*)
(**)
(*Update: Previously TensorIsZero does not account for scalars. Now it does.*)
(**)
(*Update: Previously the description of Metric did not include the optional arguments ChristoffelOperator->op, RiemannOperator->op, RicciOperator->op, RicciScalarOperator->op. Now it does.*)


(* ::Text:: *)
(*(April and May) 2016*)
(**)
(*Update! New function LeviCivita implements the generally covariant Levi-Civita (pseudo-)tensor.*)
(**)
(*Update! New function CovariantHodgeDual implements the generall covariant Hodge dual (aka Hodge star) operation. It checks whether the tensor whose dual is being computed is fully antisymmetric.*)
(**)
(*Update! New function UniqueIndices takes in a Tensor and returns the same Tensor but with its indices replaced with Unique ones.*)
(**)
(*Update! New function RaiseAllIndices[t,m] takes in a tensor t and returns it with all indices raised using the Metric Tensor m.*)
(**)
(*Update! New function LowerAllIndices[t,m] takes in a tensor t and returns it with all indices lowered using the Metric Tensor m.*)
(**)
(*Update: (Internal) CheckMetricTensor[m_Tensor] returns True if m is of type "Metric" and False otherwise.*)
(**)
(*Update: Previously, Coordinates only reads coordinates from a Metric Tensor. Now it reads in any Tensor.*)
(**)
(*Update: The portion of code in CovariantD involving Christoffel symbols was re-written to exploit TensorProduct, TensorContract and Transpose.*)
(**)
(*Update!! New functions pre-pended with "MHD" implement the PDEs of ideal MHD in 4D curved spacetimes. Currently, the main functions are:*)
(*		MHDSystem, MHDMaxwellCurrent, MHDEquations, MHDMetricTensor, MHDScalar, MHD3Form, MHDPlasmaCurrent, MHDMaxwell, *)
(*		MHDMaxwellCurrent, MHDRank2P, MHDEnergyMomentumShearStress, MHDMetric, MHDLagrangian, MHDPlasmaEnergyDensity*)
(*	Note: MHDSystem allows either sign conventions for the metric to be used.*)
(**)
(*Update: TensorComponents now threads over Plus automatically.*)
(**)
(*Update: Now, TensorComponents[(Non-Tensor stuff) x Tensor1 x Tensor2 ...] = (Non-Tensor stuff) TensorComponents[Tensor1 x Tensor2 ...].*)
(**)
(*Update: Tensor Code involving Einstein summation has been simplified to use TensorContract directly/solely. Previously, an additional contraction involving the identity matrix was employed.*)
(**)
(*Update: MoveIndices code re-written to employ TensorProduct, Transpose and TensorContract.*)
(**)
(*Update: ContractTensors is re-instated. It now perform a TensorProduct of sorts of Tensor objects, but \[LongDash] for now \[LongDash] only those Tensors with the same CoordinateSystem.*)
(**)
(*Update: (Internal) FormatTensorName will be applied to TensorName of a Tensor to format it in special cases, for e.g., when Tensor is a TensorProduct.*)
(**)
(*Update: Now, CovariantD[\[Mu]_,(Non-Tensor stuff) x Tensor1 x Tensor2 ...,m_] = (Non-Tensor stuff) CovariantD[\[Mu], Tensor1 x Tensor2 ..., m]; CovariantD distributes over Plus; and CovariantD now acts on a product of Tensors m by first applying ContractTensors to m, so that CovariantD can act on it as a single Tensor object. CovariantD now also obeys the product rule of differentiation.*)
(**)
(*Update: TensorSymmetry[m_Tensor] now does TensorSymmetry[TensorComponents[m]].*)
(**)
(*Spring 2016*)
(**)
(*Update: Ideal Magneto-hydrodynamics (iMHD) functionality added. Updates to iMHD-related functions will appear in its subsection above.*)
(**)
(*October 2017*)
(**)
(*Update: GeodesicSystem takes in as input a Metric Tensor, an affine parameter, and a non-affine parameter; and outputs a List: {Geodesic Lagrangian in affine parameter form, Geodesic Lagrangian in non-affine parameter form, Geodesic equations in affine parameter form, Geodesic equations in non-affine parameter form}.*)
(**)
(*Update: GeodesicLagrangians takes in as input a Metric Tensor, an affine parameter, and a non-affine parameter; and outputs a List: {Geodesic Lagrangian in affine parameter form, Geodesic Lagrangian in non-affine parameter form}. That is, it does what GeodesicSystem does, but does not output the geodesic equations themselves.*)
(**)
(*February 2018*)
(**)
(*Update: ToTensor returns a Tensor.*)
(**)
(*Update: LieDerivative returns the Lie derivative of a metric.*)
(**)
(*May 2019*)
(**)
(*Update: Mathematica function Dimensions now may be applied to Tensor objects. It does Dimensions[TensorComponents[Tensor[stuff]]]; i.e., it returns the Dimensions of the TensorComponents.*)
(**)
(*Update: The Weyl tensor, being the traceless part of Riemann, is zero in two and three dimensions. TensoriaCalc now immediately outputs a zero tensor whenever the space(time) dimension is 2 or 3; previously, it computes Weyl when d=3 (which, of course, will always yield zero) and gives an error when d=2. The reason for the error in the latter is due to the generic formula for the Weyl tensor breaking down, as it contains factors of 1/(d-2); this in turn is related to the fact that the Einstein tensor is zero in 2D.*)
(**)
(*October 2019*)
(**)
(*Update: NonMetric Tensor now has an additional argument; i.e., it's now NonMetricTensor[\[Mu]T_List,stuff_List,exp_,CoordinateSystem->coords_List,opts:OptionsPattern[]], where the new argumenet exp refers to the TensorName -> exp. The name of the Tensor should not be Optional.*)
(**)
(*Update: The function ToTensor was deleted, because it overlaps with NonMetricTensor.*)
(**)
(*February 2020*)
(**)
(*Update: CoordinateTransformation is now able to coordinate-transform Tensors of TensorType "Metric".*)
(**)
(*Update: Section "Geometry" is now renamed "Library of Functions".*)
(**)
(*April 2020*)
(**)
(*Update: New function GeodesicHamiltonianDynamics computes the Hamilton and the associated Hamilton's equations for geodesic motion, given a metric, definitions of momenta, and the affine parameter variable.*)
