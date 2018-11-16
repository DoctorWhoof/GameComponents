Namespace gui3d

#Import "<std>"
#Import "<mojo>"
#Import "<mojo3d>"

#Import "source/GuiComponent"
#Import "extensions/Scene"
#Import "extensions/Entity"
#Import "extensions/Canvas"

Using std..
Using mojo..
Using mojo3d..

Global componentMap := New Map< Entity, Stack<GuiComponent> >