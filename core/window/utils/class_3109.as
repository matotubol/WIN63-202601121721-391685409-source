package com.sulake.core.window.utils
{
   public class class_3109
   {
      
      public static const NORMAL:String = "normal";
      
      public static const ITALIC:String = "italic";
      
      public static const BOLD:String = "bold";
      
      public static const const_70:String = "underline";
      
      public static const NONE:String = "none";
      
      public static const ADVANCED:String = "advanced";
      
      public static const TOP_LEFT:String = "top-left";
      
      public static const TOP:String = "top";
      
      public static const TOP_RIGHT:String = "top-right";
      
      public static const const_47:String = "left";
      
      public static const RIGHT:String = "right";
      
      public static const BOTTOM_LEFT:String = "bottom-left";
      
      public static const BOTTOM:String = "bottom";
      
      public static const BOTTOM_RIGHT:String = "bottom-right";
      
      public var name:String;
      
      public var color:Object;
      
      public var fontFamily:String;
      
      public var fontSize:Object = null;
      
      public var fontStyle:String = null;
      
      public var fontWeight:String = null;
      
      public var kerning:Object = null;
      
      public var leading:Object = null;
      
      public var letterSpacing:Object = null;
      
      public var textDecoration:String = null;
      
      public var textIndent:Object = null;
      
      public var antiAliasType:String = null;
      
      public var sharpness:Object = null;
      
      public var thickness:Object = null;
      
      public var etchingColor:Object = null;
      
      public var etchingPosition:Object = null;
      
      public function class_3109()
      {
         super();
      }
      
      public function toString() : String
      {
         var _loc1_:String = "";
         _loc1_ += name + " {\n";
         if(color)
         {
            _loc1_ += "\tcolor: #" + color.toString() + ";\n";
         }
         if(fontFamily)
         {
            _loc1_ += "\tfont-family: " + fontFamily + ";\n";
         }
         if(fontSize)
         {
            _loc1_ += "\tfont-size: " + fontSize + ";\n";
         }
         if(fontStyle)
         {
            _loc1_ += "\tfont-style: " + fontStyle + ";\n";
         }
         if(fontWeight)
         {
            _loc1_ += "\tfont-weight: " + fontWeight + ";\n";
         }
         if(kerning)
         {
            _loc1_ += "\tkerning: " + kerning + ";\n";
         }
         if(leading)
         {
            _loc1_ += "\tleading: " + leading + ";\n";
         }
         if(letterSpacing)
         {
            _loc1_ += "\tletter-spacing: " + letterSpacing + ";\n";
         }
         if(textDecoration)
         {
            _loc1_ += "\ttext-decoration: " + textDecoration + ";\n";
         }
         if(textIndent)
         {
            _loc1_ += "\ttext-indent: " + textIndent + ";\n";
         }
         if(antiAliasType)
         {
            _loc1_ += "\tanti-alias-type: " + antiAliasType + ";\n";
         }
         if(sharpness)
         {
            _loc1_ += "\tsharpness: " + sharpness + ";\n";
         }
         if(thickness)
         {
            _loc1_ += "\tthickness: " + thickness + ";\n";
         }
         if(etchingColor)
         {
            _loc1_ += "\tetching-color: #" + etchingColor.toString() + ";\n";
         }
         if(etchingPosition)
         {
            _loc1_ += "\tetching-direction: " + etchingPosition + ";\n";
         }
         return _loc1_ + "}";
      }
      
      public function equals(param1:class_3109) : Boolean
      {
         return color == param1.color && fontFamily == param1.fontFamily && fontSize == param1.fontSize && fontStyle == param1.fontStyle && fontWeight == param1.fontWeight && kerning == param1.kerning && leading == param1.leading && letterSpacing == param1.letterSpacing && textDecoration == param1.textDecoration && textIndent == param1.textIndent && antiAliasType == param1.antiAliasType && sharpness == param1.sharpness && thickness == param1.thickness && etchingColor == param1.etchingColor && etchingPosition == param1.etchingPosition;
      }
      
      public function clone() : class_3109
      {
         var _loc1_:class_3109 = new class_3109();
         _loc1_.name = name;
         _loc1_.color = color;
         _loc1_.fontFamily = fontFamily;
         _loc1_.fontSize = fontSize;
         _loc1_.fontStyle = fontStyle;
         _loc1_.fontWeight = fontWeight;
         _loc1_.kerning = kerning;
         _loc1_.leading = leading;
         _loc1_.letterSpacing = letterSpacing;
         _loc1_.textDecoration = textDecoration;
         _loc1_.textIndent = textIndent;
         _loc1_.antiAliasType = antiAliasType;
         _loc1_.sharpness = sharpness;
         _loc1_.thickness = thickness;
         _loc1_.etchingColor = etchingColor;
         _loc1_.etchingPosition = etchingPosition;
         return _loc1_;
      }
   }
}

