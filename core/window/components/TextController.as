package com.sulake.core.window.components
{
   import com.sulake.core.localization.ILocalizable;
   import com.sulake.core.utils.class_1860;
   import com.sulake.core.utils.class_2468;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.theme.class_2901;
   import com.sulake.core.window.utils.IMargins;
   import com.sulake.core.window.utils.ITextFieldContainer;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.TextMargins;
   import com.sulake.core.window.utils.class_3109;
   import com.sulake.core.window.utils.class_3398;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.Font;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   import flash.utils.Dictionary;
   
   public class TextController extends WindowController implements ITextWindow, ITextFieldContainer, ILocalizable
   {
      
      private static var ALL_FONTS:Array = Font.enumerateFonts();
      
      private static const REPLACE_RANDOM_CHARS:Array = ["a","B","c","D","e"];
      
      protected static const const_27:Dictionary = createPropertySetterTable();
      
      private var _overFlowReplace:String = "";
      
      private var var_1849:Boolean = false;
      
      protected var _field:TextField;
      
      protected var var_1398:Number = 0;
      
      protected var var_818:Number = 0;
      
      protected var _drawing:Boolean = false;
      
      protected var var_84:TextMargins;
      
      protected var var_543:String = "none";
      
      protected var _localized:Boolean = false;
      
      protected var var_4058:int = 0;
      
      protected var var_1067:Boolean = false;
      
      protected var _etchingColor:uint;
      
      protected var var_3040:String;
      
      protected var var_5317:TextFormat;
      
      private var _textStyleName:String;
      
      private var var_310:class_3109 = new class_3109();
      
      protected var _settingRectangle:Boolean;
      
      public function TextController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var_84 = new TextMargins(0,0,0,0,setTextMargins);
         if(_field == null)
         {
            _field = new TextField();
            if(param6)
            {
               _field.width = param6.width;
               _field.height = param6.height;
            }
            _field.antiAliasType = "advanced";
            _field.gridFitType = "pixel";
            _field.mouseWheelEnabled = false;
         }
         _textStyleName = String(param5.getWindowFactory().getThemeManager().getPropertyDefaults(param3).method_20("text_style"));
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         setTextFormatting(this);
         class_3398.events.addEventListener("change",onTextStyleChanged);
         antiAliasType = "advanced";
         gridFitType = "pixel";
         if(_field.autoSize == "none")
         {
            _field.width = var_29;
            _field.height = var_32;
         }
      }
      
      private static function setAntiAliasType(param1:TextController, param2:String) : void
      {
         param2 = param2 == "normal" ? "normal" : "advanced";
         param1.var_310.antiAliasType = param2;
         param1._field.antiAliasType = param2;
         param1.refreshTextImage();
      }
      
      private static function setAlwaysShowSelection(param1:TextController, param2:Boolean) : void
      {
         param1._field.alwaysShowSelection = param2;
      }
      
      private static function setAutoSize(param1:TextController, param2:String) : void
      {
         if(param2 != param1.var_543)
         {
            param1.var_543 = param2;
            param1._field.autoSize = param2 != "none" ? "left" : "none";
            var _loc3_:TextFormat = param1.defaultTextFormat;
            switch(param2)
            {
               case "center":
                  null.align = "center";
                  break;
               case "right":
                  null.align = "right";
                  break;
               default:
                  null.align = "left";
            }
            param1.setTextFormat(new TextFormat(null.font,null.size,null.color,null.bold,null.italic,null.underline,null.url,null.target,null.align,null.leftMargin,null.rightMargin,null.indent,null.leading));
            param1.defaultTextFormat = null;
            param1.refreshTextImage();
         }
      }
      
      private static function setTextBackground(param1:TextController, param2:Boolean) : void
      {
         param1.background = param2;
      }
      
      private static function setTextBackgroundColor(param1:TextController, param2:uint) : void
      {
         param1.color = param2;
      }
      
      private static function setBold(param1:TextController, param2:Boolean) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.bold = param2;
         param1.setTextFormat(new TextFormat(_loc3_.font,_loc3_.size,_loc3_.color,_loc3_.bold,_loc3_.italic,_loc3_.underline,_loc3_.url,_loc3_.target,_loc3_.align,_loc3_.leftMargin,_loc3_.rightMargin,_loc3_.indent,_loc3_.leading));
         param1.defaultTextFormat = _loc3_;
         param1.var_310.fontWeight = "bold";
      }
      
      private static function setBorder(param1:TextController, param2:Boolean) : void
      {
         param1._field.border = param2;
         param1.refreshTextImage();
      }
      
      private static function setBorderColor(param1:TextController, param2:uint) : void
      {
         param1._field.borderColor = param2;
         param1.refreshTextImage();
      }
      
      private static function setCondenseWhite(param1:TextController, param2:Boolean) : void
      {
         param1._field.condenseWhite = param2;
         param1.refreshTextImage();
      }
      
      private static function setDefaultTextFormat(param1:TextController, param2:TextFormat) : void
      {
         param1._field.defaultTextFormat = param2;
         param1.refreshTextImage();
      }
      
      private static function setEmbedFonts(param1:TextController, param2:Boolean) : void
      {
         param1._field.embedFonts = param2;
      }
      
      private static function setFontFace(param1:TextController, param2:String) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.font = param2;
         param1.setTextFormat(new TextFormat(_loc3_.font,_loc3_.size,_loc3_.color,_loc3_.bold,_loc3_.italic,_loc3_.underline,_loc3_.url,_loc3_.target,_loc3_.align,_loc3_.leftMargin,_loc3_.rightMargin,_loc3_.indent,_loc3_.leading));
         param1._field.embedFonts = class_1860.isEmbeddedFont(param2);
         param1.defaultTextFormat = _loc3_;
         param1.var_310.fontFamily = param2;
      }
      
      private static function setFontSize(param1:TextController, param2:uint) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.size = param2;
         param1.setTextFormat(new TextFormat(_loc3_.font,_loc3_.size,_loc3_.color,_loc3_.bold,_loc3_.italic,_loc3_.underline,_loc3_.url,_loc3_.target,_loc3_.align,_loc3_.leftMargin,_loc3_.rightMargin,_loc3_.indent,_loc3_.leading));
         param1.defaultTextFormat = _loc3_;
         param1.var_310.fontSize = param2;
      }
      
      private static function setGridFitType(param1:TextController, param2:String) : void
      {
         param1._field.gridFitType = param2;
         param1.refreshTextImage();
      }
      
      private static function setHtmlText(param1:TextController, param2:String) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(param1._localized)
         {
            param1.context.removeLocalizationListener(param1._caption.slice(2,param1._caption.indexOf("}")),param1);
            param1._localized = false;
         }
         param1._caption = param2;
         if(param1._caption.charAt(0) == "$" && param1._caption.charAt(1) == "{")
         {
            param1.context.registerLocalizationListener(param1._caption.slice(2,param1._caption.indexOf("}")),param1);
            param1._localized = true;
         }
         else if(param1._field != null)
         {
            param1._field.htmlText = param1._caption;
            param1.refreshTextImage();
         }
      }
      
      private static function setItalic(param1:TextController, param2:Boolean) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.italic = param2;
         param1.setTextFormat(new TextFormat(_loc3_.font,_loc3_.size,_loc3_.color,_loc3_.bold,_loc3_.italic,_loc3_.underline,_loc3_.url,_loc3_.target,_loc3_.align,_loc3_.leftMargin,_loc3_.rightMargin,_loc3_.indent,_loc3_.leading));
         param1.defaultTextFormat = _loc3_;
         param1.var_310.fontStyle = param2 ? "italic" : "normal";
      }
      
      private static function setKerning(param1:TextController, param2:Boolean) : void
      {
         var _loc4_:TextFormat = param1.defaultTextFormat;
         _loc4_.kerning = param2;
         var _loc3_:TextFormat = new TextFormat(_loc4_.font,_loc4_.size,_loc4_.color,_loc4_.bold,_loc4_.italic,_loc4_.underline,_loc4_.url,_loc4_.target,_loc4_.align,_loc4_.leftMargin,_loc4_.rightMargin,_loc4_.indent,_loc4_.leading);
         _loc3_.kerning = param2;
         param1.setTextFormat(_loc3_);
         param1.defaultTextFormat = _loc4_;
         param1.var_310.kerning = param2;
      }
      
      private static function setTextMarginMap(param1:TextController, param2:class_55) : void
      {
         if(param1.var_84)
         {
            param1.var_84.assign(int(param2["left"]),int(param2["top"]),int(param2["right"]),int(param2["bottom"]),param1.setTextMargins);
         }
         else
         {
            param1.var_84 = new TextMargins(int(param2["left"]),int(param2["top"]),int(param2["right"]),int(param2["bottom"]),param1.setTextMargins);
         }
         param1.refreshTextImage();
      }
      
      private static function setMarginLeft(param1:TextController, param2:int) : void
      {
         if(param1.var_84 && param1.var_84.left != param2)
         {
            param1.margins.left = param2;
         }
      }
      
      private static function setMarginTop(param1:TextController, param2:int) : void
      {
         if(param1.var_84 && param1.var_84.top != param2)
         {
            param1.margins.top = param2;
         }
      }
      
      private static function setMarginRight(param1:TextController, param2:int) : void
      {
         if(param1.var_84 && param1.var_84.right != param2)
         {
            param1.margins.right = param2;
         }
      }
      
      private static function setMarginBottom(param1:TextController, param2:int) : void
      {
         if(param1.var_84 && param1.var_84.bottom != param2)
         {
            param1.margins.bottom = param2;
         }
      }
      
      private static function setMaxChars(param1:TextController, param2:int) : void
      {
         param1._field.maxChars = param2;
         param1.refreshTextImage();
      }
      
      private static function setMouseWheelEnabled(param1:TextController, param2:Boolean) : void
      {
         param1._field.mouseWheelEnabled = param2;
      }
      
      private static function setMultiline(param1:TextController, param2:Boolean) : void
      {
         param1._field.multiline = param2;
         param1.refreshTextImage();
      }
      
      private static function setRestrict(param1:TextController, param2:String) : void
      {
         param1._field.restrict = param2;
      }
      
      private static function setSharpness(param1:TextController, param2:Number) : void
      {
         param1._field.sharpness = param2;
         param1.refreshTextImage();
         param1.var_310.sharpness = param2;
      }
      
      private static function setSpacing(param1:TextController, param2:Number) : void
      {
         var _loc4_:TextFormat = param1.defaultTextFormat;
         _loc4_.letterSpacing = param2;
         var _loc3_:TextFormat = new TextFormat(_loc4_.font,_loc4_.size,_loc4_.color,_loc4_.bold,_loc4_.italic,_loc4_.underline,_loc4_.url,_loc4_.target,_loc4_.align,_loc4_.leftMargin,_loc4_.rightMargin,_loc4_.indent,_loc4_.leading);
         _loc3_.letterSpacing = param2;
         param1.setTextFormat(_loc3_);
         param1.defaultTextFormat = _loc4_;
         param1.var_310.letterSpacing = param2;
      }
      
      private static function setMaxLines(param1:TextController, param2:int) : void
      {
         param1.var_4058 = param2;
         param1.refreshTextImage();
      }
      
      private static function setLeading(param1:TextController, param2:Number) : void
      {
         var _loc4_:TextFormat = param1.defaultTextFormat;
         _loc4_.leading = param2;
         var _loc3_:TextFormat = new TextFormat(_loc4_.font,_loc4_.size,_loc4_.color,_loc4_.bold,_loc4_.italic,_loc4_.underline,_loc4_.url,_loc4_.target,_loc4_.align,_loc4_.leftMargin,_loc4_.rightMargin,_loc4_.indent,_loc4_.leading);
         _loc3_.leading = param2;
         param1.setTextFormat(_loc3_);
         param1.defaultTextFormat = _loc4_;
         param1.var_310.leading = param2;
      }
      
      private static function setTextColor(param1:TextController, param2:uint) : void
      {
         param1._field.textColor = param2;
         param1.refreshTextImage();
         param1.var_310.color = param2;
      }
      
      private static function setTextStyle(param1:TextController, param2:class_3109) : void
      {
         if(!param1 || !param2)
         {
            return;
         }
         var _loc3_:class_3109 = class_3398.getStyle(param2.name);
         if(_loc3_ && !_loc3_.equals(param2))
         {
            _loc3_ = class_3398.findMatchingTextStyle(param2.toString());
         }
         if(_loc3_)
         {
            param1._textStyleName = _loc3_.name;
            setTextFormatting(param1);
            param1.refreshTextImage();
         }
      }
      
      private static function setTextStyleString(param1:TextController, param2:String) : void
      {
         var _loc4_:TextFormat = null;
         var _loc3_:class_3109 = class_3398.getStyle(param2);
         if(!_loc3_)
         {
            _loc3_ = class_3398.findMatchingTextStyle(param2);
         }
         if(_loc3_)
         {
            param1._textStyleName = _loc3_.name;
            setTextFormatting(param1);
            param1.refreshTextImage();
         }
         else
         {
            _loc3_ = class_3398.parseCSS(param2)[0];
            if(_loc3_)
            {
               if(!class_3398.getStyle(_loc3_.name))
               {
                  class_3398.setStyle(_loc3_.name,_loc3_);
               }
               setTextStyle(param1,_loc3_);
            }
         }
         if(param1.var_543 == "center")
         {
            _loc4_ = new TextFormat();
            _loc4_.align = "center";
            param1._field.setTextFormat(_loc4_);
         }
      }
      
      private static function setThickness(param1:TextController, param2:Number) : void
      {
         param1._field.thickness = param2;
         param1.refreshTextImage();
         param1.var_310.thickness = param2;
      }
      
      private static function setUnderline(param1:TextController, param2:Boolean) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.underline = param2;
         param1.setTextFormat(new TextFormat(_loc3_.font,_loc3_.size,_loc3_.color,_loc3_.bold,_loc3_.italic,_loc3_.underline,_loc3_.url,_loc3_.target,_loc3_.align,_loc3_.leftMargin,_loc3_.rightMargin,_loc3_.indent,_loc3_.leading));
         param1.defaultTextFormat = _loc3_;
         param1.var_310.textDecoration = param2 ? "underline" : "none";
      }
      
      private static function setWordWrap(param1:TextController, param2:Boolean) : void
      {
         param1._field.wordWrap = param2;
         param1.refreshTextImage();
      }
      
      private static function setOverflowReplace(param1:TextController, param2:String) : void
      {
         param1._overFlowReplace = param2;
         param1.refreshTextImage();
      }
      
      protected static function setTextFormatting(param1:TextController) : void
      {
         var _loc3_:TextField = param1._field;
         var _loc4_:String = param1._textStyleName;
         var _loc2_:class_3109 = param1.var_310;
         var _loc5_:class_3109 = class_3398.getStyle(_loc4_);
         var _loc6_:TextFormat = _loc3_.defaultTextFormat;
         if(!_loc5_)
         {
            _loc5_ = class_3398.getStyle("regular");
         }
         if(!_loc5_.color)
         {
            _loc5_.color = 0;
         }
         if(!_loc2_.fontFamily)
         {
            _loc6_.font = _loc5_.fontFamily;
         }
         if(!_loc2_.fontSize)
         {
            _loc6_.size = _loc5_.fontSize;
         }
         if(!_loc2_.color)
         {
            _loc6_.color = _loc5_.color;
         }
         if(!_loc2_.fontWeight)
         {
            _loc6_.bold = _loc5_.fontWeight == "bold" ? true : null;
         }
         if(!_loc2_.fontStyle)
         {
            _loc6_.italic = _loc5_.fontStyle == "italic" ? true : null;
         }
         if(!_loc2_.textDecoration)
         {
            _loc6_.underline = _loc5_.textDecoration == "underline" ? true : null;
         }
         if(!_loc2_.textIndent)
         {
            _loc6_.indent = _loc5_.textIndent;
         }
         if(!_loc2_.leading)
         {
            _loc6_.leading = _loc5_.leading;
         }
         if(!_loc2_.kerning)
         {
            _loc6_.kerning = _loc5_.kerning;
         }
         if(!_loc2_.letterSpacing)
         {
            _loc6_.letterSpacing = _loc5_.letterSpacing;
         }
         if(!_loc2_.antiAliasType)
         {
            if(_loc5_.antiAliasType == "normal")
            {
               _loc3_.antiAliasType = "normal";
            }
            else
            {
               _loc3_.antiAliasType = "advanced";
               _loc3_.gridFitType = "pixel";
            }
         }
         if(!_loc2_.sharpness)
         {
            _loc3_.sharpness = int(_loc5_.sharpness);
         }
         if(!_loc2_.thickness)
         {
            _loc3_.thickness = int(_loc5_.thickness);
         }
         if(_loc2_.etchingColor == null)
         {
            param1.etchingColor = uint(_loc5_.etchingColor);
         }
         if(_loc2_.etchingPosition == null)
         {
            param1.etchingPosition = String(_loc5_.etchingPosition);
         }
         if(!_loc5_.fontWeight && !_loc2_.fontWeight)
         {
            _loc6_.bold = false;
         }
         if(!_loc5_.fontStyle && !_loc2_.fontStyle)
         {
            _loc6_.italic = false;
         }
         if(!_loc5_.textDecoration && !_loc2_.textDecoration)
         {
            _loc6_.underline = false;
         }
         if(!_loc5_.textIndent && !_loc2_.textIndent)
         {
            _loc6_.indent = 0;
         }
         if(!_loc5_.leading && !_loc2_.leading)
         {
            _loc6_.leading = 0;
         }
         if(!_loc5_.kerning && !_loc2_.kerning)
         {
            _loc6_.kerning = false;
         }
         if(!_loc5_.letterSpacing && !_loc2_.letterSpacing)
         {
            _loc6_.letterSpacing = 0;
         }
         if(!_loc5_.antiAliasType && !_loc2_.antiAliasType)
         {
            _loc3_.antiAliasType = "advanced";
            _loc3_.gridFitType = "pixel";
         }
         if(!_loc5_.sharpness && !_loc2_.sharpness)
         {
            _loc3_.sharpness = 0;
         }
         if(!_loc5_.thickness && !_loc2_.thickness)
         {
            _loc3_.thickness = 0;
         }
         if(_loc5_.etchingColor == null && _loc2_.etchingColor == null)
         {
            param1.etchingColor = 0;
         }
         if(_loc5_.etchingPosition == null && _loc2_.etchingPosition == null)
         {
            param1.etchingPosition = "bottom";
         }
         _loc3_.setTextFormat(_loc6_);
         _loc3_.embedFonts = class_1860.isEmbeddedFont(_loc6_.font);
         _loc3_.defaultTextFormat = _loc6_;
         param1.var_5317 = _loc6_;
      }
      
      protected static function createPropertySetterTable() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         _loc1_["always_show_selection"] = setAlwaysShowSelection;
         _loc1_["background"] = setTextBackground;
         _loc1_["background_color"] = setTextBackgroundColor;
         _loc1_["bold"] = setBold;
         _loc1_["border"] = setBorder;
         _loc1_["border_color"] = setBorderColor;
         _loc1_["condense_white"] = setCondenseWhite;
         _loc1_["default_text_format"] = setDefaultTextFormat;
         _loc1_["etching_color"] = setEtchingColor;
         _loc1_["etching_position"] = setEtchingPosition;
         _loc1_["font_face"] = setFontFace;
         _loc1_["font_size"] = setFontSize;
         _loc1_["grid_fit_type"] = setGridFitType;
         _loc1_["italic"] = setItalic;
         _loc1_["kerning"] = setKerning;
         _loc1_["max_chars"] = setMaxChars;
         _loc1_["multiline"] = setMultiline;
         _loc1_["restrict"] = setRestrict;
         _loc1_["spacing"] = setSpacing;
         _loc1_["sharpness"] = setSharpness;
         _loc1_["thickness"] = setThickness;
         _loc1_["underline"] = setUnderline;
         _loc1_["word_wrap"] = setWordWrap;
         _loc1_["margins"] = setTextMarginMap;
         _loc1_["max_lines"] = setMaxLines;
         _loc1_["leading"] = setLeading;
         _loc1_["antialias_type"] = setAntiAliasType;
         _loc1_["auto_size"] = setAutoSize;
         _loc1_["mouse_wheel_enabled"] = setMouseWheelEnabled;
         _loc1_["text_color"] = setTextColor;
         _loc1_["text_style"] = setTextStyleString;
         _loc1_["margin_left"] = setMarginLeft;
         _loc1_["margin_top"] = setMarginTop;
         _loc1_["margin_right"] = setMarginRight;
         _loc1_["margin_bottom"] = setMarginBottom;
         _loc1_["overflow_replace"] = setOverflowReplace;
         return _loc1_;
      }
      
      private static function setEtchingColor(param1:TextController, param2:uint) : void
      {
         param1._etchingColor = param2;
         param1.refreshTextImage();
         param1.var_310.etchingColor = param1._etchingColor;
      }
      
      private static function setEtchingPosition(param1:TextController, param2:String) : void
      {
         param1.var_3040 = param2;
         param1.refreshTextImage();
         param1.var_310.etchingPosition = param1.var_3040;
      }
      
      public function get antiAliasType() : String
      {
         return _field.antiAliasType;
      }
      
      public function get autoSize() : String
      {
         return var_543;
      }
      
      public function get bold() : Boolean
      {
         return _field.defaultTextFormat.bold;
      }
      
      public function get border() : Boolean
      {
         return _field.border;
      }
      
      public function get borderColor() : uint
      {
         return _field.borderColor;
      }
      
      public function get bottomScrollV() : int
      {
         return _field.bottomScrollV;
      }
      
      public function get defaultTextFormat() : TextFormat
      {
         return _field.defaultTextFormat;
      }
      
      public function get embedFonts() : Boolean
      {
         return _field.embedFonts;
      }
      
      public function get fontFace() : String
      {
         return _field.defaultTextFormat.font;
      }
      
      public function get fontSize() : uint
      {
         return _field.defaultTextFormat.size == null ? 12 : uint(_field.defaultTextFormat.size);
      }
      
      public function get gridFitType() : String
      {
         return _field.gridFitType;
      }
      
      public function get htmlText() : String
      {
         return _field.htmlText;
      }
      
      public function get italic() : Boolean
      {
         return _field.defaultTextFormat.italic;
      }
      
      public function get kerning() : Boolean
      {
         return _field.defaultTextFormat.kerning;
      }
      
      public function get length() : int
      {
         return _field.length;
      }
      
      public function get margins() : IMargins
      {
         return var_84;
      }
      
      public function get maxChars() : int
      {
         return _field.maxChars;
      }
      
      public function get multiline() : Boolean
      {
         return _field.multiline;
      }
      
      public function get numLines() : int
      {
         return _field.numLines;
      }
      
      public function get restrict() : String
      {
         return _field.restrict;
      }
      
      public function get sharpness() : Number
      {
         return _field.sharpness;
      }
      
      public function get spacing() : Number
      {
         return Number(_field.defaultTextFormat.letterSpacing);
      }
      
      public function get text() : String
      {
         return _field != null ? _field.text : "";
      }
      
      public function get textColor() : uint
      {
         return _field.textColor;
      }
      
      public function get textBackground() : Boolean
      {
         return background;
      }
      
      public function get textBackgroundColor() : uint
      {
         return color;
      }
      
      public function get textHeight() : Number
      {
         return _field.textHeight;
      }
      
      public function get textWidth() : Number
      {
         return _field.textWidth;
      }
      
      public function get textStyle() : class_3109
      {
         return class_3398.getStyle(_textStyleName);
      }
      
      public function get thickness() : Number
      {
         return _field.thickness;
      }
      
      public function get underline() : Boolean
      {
         return _field.defaultTextFormat.underline;
      }
      
      public function get wordWrap() : Boolean
      {
         return _field.wordWrap;
      }
      
      public function get textField() : TextField
      {
         return _field;
      }
      
      public function get maxLines() : int
      {
         return var_4058;
      }
      
      public function get leading() : Number
      {
         return Number(_field.defaultTextFormat.leading);
      }
      
      public function get isOverflowReplaceOn() : Boolean
      {
         return _overFlowReplace != "";
      }
      
      public function get overflowReplace() : String
      {
         return _overFlowReplace;
      }
      
      public function get scrollH() : Number
      {
         return var_1398;
      }
      
      public function get scrollV() : Number
      {
         return var_818;
      }
      
      public function get maxScrollH() : int
      {
         return _field.maxScrollH;
      }
      
      public function get maxScrollV() : int
      {
         return Math.max(_field.textHeight - height,0);
      }
      
      public function set antiAliasType(param1:String) : void
      {
         setAntiAliasType(this,param1);
      }
      
      public function set autoSize(param1:String) : void
      {
         setAutoSize(this,param1);
      }
      
      public function set bold(param1:Boolean) : void
      {
         setBold(this,param1);
      }
      
      public function set border(param1:Boolean) : void
      {
         setBorder(this,param1);
      }
      
      public function set borderColor(param1:uint) : void
      {
         setBorderColor(this,param1);
      }
      
      public function set defaultTextFormat(param1:TextFormat) : void
      {
         setDefaultTextFormat(this,param1);
      }
      
      public function set embedFonts(param1:Boolean) : void
      {
         setEmbedFonts(this,param1);
      }
      
      public function set fontFace(param1:String) : void
      {
         setFontFace(this,param1);
      }
      
      public function set fontSize(param1:uint) : void
      {
         setFontSize(this,param1);
      }
      
      public function set gridFitType(param1:String) : void
      {
         setGridFitType(this,param1);
      }
      
      public function set htmlText(param1:String) : void
      {
         setHtmlText(this,param1);
      }
      
      public function set italic(param1:Boolean) : void
      {
         setItalic(this,param1);
      }
      
      public function set kerning(param1:Boolean) : void
      {
         setKerning(this,param1);
      }
      
      public function set maxChars(param1:int) : void
      {
         setMaxChars(this,param1);
      }
      
      public function set multiline(param1:Boolean) : void
      {
         setMultiline(this,param1);
      }
      
      public function set restrict(param1:String) : void
      {
         setRestrict(this,param1);
      }
      
      public function set sharpness(param1:Number) : void
      {
         setSharpness(this,param1);
      }
      
      public function set spacing(param1:Number) : void
      {
         setSpacing(this,param1);
      }
      
      public function set textColor(param1:uint) : void
      {
         setTextColor(this,param1);
      }
      
      public function set textBackground(param1:Boolean) : void
      {
         setTextBackground(this,param1);
      }
      
      public function set textBackgroundColor(param1:uint) : void
      {
         setTextBackgroundColor(this,param1);
      }
      
      public function set textStyle(param1:class_3109) : void
      {
         setTextStyle(this,param1);
      }
      
      public function set thickness(param1:Number) : void
      {
         setThickness(this,param1);
      }
      
      public function set underline(param1:Boolean) : void
      {
         setUnderline(this,param1);
      }
      
      public function set wordWrap(param1:Boolean) : void
      {
         setWordWrap(this,param1);
      }
      
      public function set maxLines(param1:int) : void
      {
         setMaxLines(this,param1);
      }
      
      public function set leading(param1:Number) : void
      {
         setLeading(this,param1);
      }
      
      public function set overflowReplace(param1:String) : void
      {
         setOverflowReplace(this,param1);
      }
      
      protected function limitStringLength(param1:String) : String
      {
         return maxChars > 0 ? param1.substr(0,maxChars) : param1;
      }
      
      override public function setRectangle(param1:int, param2:int, param3:int, param4:int) : void
      {
         if(_settingRectangle || !multiline || !wordWrap)
         {
            super.setRectangle(param1,param2,param3,param4);
            return;
         }
         if(var_25 == param1 && var_29 == param3)
         {
            super.setRectangle(param1,param2,param3,param4);
            return;
         }
         _settingRectangle = true;
         var _loc5_:String = autoSize;
         autoSize = "none";
         super.setRectangle(param1,param2,param3,param4);
         autoSize = _loc5_;
         _settingRectangle = false;
      }
      
      public function set scrollH(param1:Number) : void
      {
         var_1398 = param1;
         _field.scrollH = var_1398 * _field.maxScrollH;
         refreshTextImage();
      }
      
      public function set scrollV(param1:Number) : void
      {
         if(param1 > var_818)
         {
            var_818 = param1;
            _field.scrollV = Math.max(_field.scrollV,param1 * _field.maxScrollV + 1);
            refreshTextImage();
         }
         else if(param1 < var_818)
         {
            var_818 = param1;
            _field.scrollV = Math.min(_field.scrollV,param1 * _field.maxScrollV - 1);
            refreshTextImage();
         }
      }
      
      public function get visibleRegion() : Rectangle
      {
         return new Rectangle(var_1398 * maxScrollH,var_818 * maxScrollV,width,height);
      }
      
      public function get scrollableRegion() : Rectangle
      {
         return new Rectangle(0,0,maxScrollH + width,maxScrollV + height);
      }
      
      public function get scrollStepH() : Number
      {
         return 10;
      }
      
      public function get scrollStepV() : Number
      {
         return _field.textHeight / _field.numLines;
      }
      
      public function set scrollStepH(param1:Number) : void
      {
      }
      
      public function set scrollStepV(param1:Number) : void
      {
      }
      
      private function replaceNonRenderableCharacters(param1:String) : String
      {
         var _loc5_:Font = null;
         var _loc3_:TextFormat = _field.getTextFormat();
         if(!_loc3_ || !_loc3_.font)
         {
            return param1;
         }
         var _loc7_:Array = ALL_FONTS;
         for each(var _loc8_ in _loc7_)
         {
            if(_loc8_.fontName.toLowerCase() == _loc3_.font.toLowerCase())
            {
               _loc5_ = _loc8_;
            }
         }
         if(_loc5_ == null)
         {
            return param1;
         }
         if(_loc5_.hasGlyphs(param1))
         {
            return param1;
         }
         var _loc6_:String = "";
         var _loc4_:int = 0;
         while(0 < param1.length)
         {
            var _loc2_:String = param1.charAt(0);
            _loc6_ = null + REPLACE_RANDOM_CHARS[Math.floor(Math.random() * REPLACE_RANDOM_CHARS.length)];
            _loc4_++;
         }
         return null;
      }
      
      public function set text(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_localized)
         {
            context.removeLocalizationListener(_caption.slice(2,_caption.indexOf("}")),this);
            _localized = false;
         }
         _caption = param1;
         if(!var_1067 && _caption.charAt(0) == "$" && _caption.charAt(1) == "{")
         {
            _localized = true;
            context.registerLocalizationListener(_caption.slice(2,_caption.indexOf("}")),this);
         }
         else if(_field != null)
         {
            _field.text = replaceNonRenderableCharacters(_caption);
            refreshTextImage();
         }
      }
      
      override public function set caption(param1:String) : void
      {
         text = param1;
      }
      
      override public function set color(param1:uint) : void
      {
         super.color = param1;
         _field.backgroundColor = param1;
      }
      
      override public function set background(param1:Boolean) : void
      {
         super.background = param1;
         _field.background = param1;
      }
      
      public function set localization(param1:String) : void
      {
         if(param1 != null && _field != null)
         {
            _field.text = limitStringLength(param1);
            refreshTextImage();
         }
      }
      
      override public function clone() : class_1741
      {
         var _loc1_:TextController = super.clone() as TextController;
         _loc1_._field.backgroundColor = color;
         _loc1_._field.background = background;
         _loc1_._field.antiAliasType = "advanced";
         _loc1_._field.gridFitType = "pixel";
         _loc1_.var_1398 = var_1398;
         _loc1_.var_818 = var_818;
         _loc1_.var_84 = var_84.clone(_loc1_.setTextMargins);
         _loc1_.var_543 = var_543;
         _loc1_._localized = _localized;
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         immediateClickMode = false;
         class_3398.events.removeEventListener("change",onTextStyleChanged);
         if(_localized)
         {
            context.removeLocalizationListener(_caption.slice(2,_caption.indexOf("}")),this);
         }
         if(var_84 != null)
         {
            var_84.dispose();
            var_84 = null;
         }
         _field = null;
         super.dispose();
      }
      
      override public function update(param1:WindowController, param2:class_1758) : Boolean
      {
         if(!_drawing)
         {
            if(param2.type == "WE_RESIZED")
            {
               refreshTextImage(true);
            }
         }
         return super.update(param1,param2);
      }
      
      protected function refreshTextImage(param1:Boolean = false) : void
      {
         if(_drawing)
         {
            return;
         }
         _drawing = true;
         var_1849 = false;
         var _loc16_:int = var_84.left + var_84.right;
         var _loc15_:int = var_84.top + var_84.bottom;
         var _loc3_:int = var_29 - 0;
         var _loc6_:int = var_32 - _loc15_;
         var _loc2_:int = Math.floor(_field.width) + (_field.border ? 1 : 0);
         var _loc13_:Boolean = false;
         if((var_543 == "none" || var_543 == "right") && isOverflowReplaceOn)
         {
            var _loc10_:String = _field.text;
            if(_field.textHeight + _loc15_ > _loc6_)
            {
               var _loc5_:int = _field.numLines - 1;
               while(_field.getCharBoundaries(_field.getLineOffset(0)) == null || _field.getCharBoundaries(_field.getLineOffset(0)).bottom > _loc6_)
               {
                  _loc5_--;
               }
               var _loc4_:int = _field.getLineOffset(0);
               var _loc7_:int;
               var _loc17_:* = _loc7_ = _loc4_ + _field.getLineLength(0);
               while(_field.textHeight + _loc15_ > _loc6_ && 0 > 0)
               {
                  _field.text = null.slice(0,(_loc17_--,0)) + overflowReplace;
                  var_1849 = true;
               }
            }
            var _loc11_:String = _field.text;
            if(_field.textWidth + 0 > _loc3_)
            {
               var _loc12_:int = _field.text.length - 1;
               while(_field.getCharBoundaries(0) == null || _field.getCharBoundaries(0).right > _loc3_)
               {
                  _loc12_--;
               }
               var _loc9_:TextFormat = getTextFormat(0,0);
               _loc17_ = 0;
               var _loc8_:int = 0 + null.indent + null.leftMargin + null.rightMargin;
               while(_field.textWidth + 0 > _loc3_ && 0 > 0)
               {
                  _field.text = null.slice(0,(_loc17_--,0)) + overflowReplace;
                  var_1849 = true;
               }
            }
            _loc2_ = Math.floor(_field.width) + (_field.border ? 1 : 0);
         }
         if(_loc2_ != _loc3_)
         {
            if(var_543 == "left")
            {
               setRectangle(var_25,var_26,_loc2_ + 0,Math.floor(_field.height) + _loc15_);
               _loc13_ = true;
            }
            else if(var_543 != "right")
            {
               if(var_543 != "center")
               {
                  _field.width = _loc3_ - (_field.border ? 1 : 0);
                  _field.height = _loc6_ - (_field.border ? 1 : 0);
               }
            }
         }
         if(_field.height + (_field.border ? 1 : 0) < _loc6_)
         {
            if(var_543 == "none")
            {
               _field.height = _loc6_ - (_field.border ? 1 : 0);
            }
            else
            {
               height = Math.floor(_field.height) + _loc15_;
               _loc13_ = true;
            }
         }
         else if(_field.height + (_field.border ? 1 : 0) > _loc6_)
         {
            if(var_543 != "none")
            {
               height = Math.floor(_field.height) + _loc15_;
               _loc13_ = true;
            }
         }
         _drawing = false;
         _context.invalidate(this,null,1);
         if(!_loc13_ && !param1 && name_1)
         {
            var _loc14_:class_1758 = class_1758.allocate("WE_RESIZED",this,null);
            name_1.dispatchEvent(null);
            null.recycle();
         }
      }
      
      public function appendText(param1:String) : void
      {
         _field.appendText(param1);
         refreshTextImage();
      }
      
      public function getCharBoundaries(param1:int) : Rectangle
      {
         return _field.getCharBoundaries(param1);
      }
      
      public function getCharIndexAtPoint(param1:Number, param2:Number) : int
      {
         return _field.getCharIndexAtPoint(param1,param2);
      }
      
      public function getFirstCharInParagraph(param1:int) : int
      {
         return _field.getFirstCharInParagraph(param1);
      }
      
      public function getImageReference(param1:String) : DisplayObject
      {
         return _field.getImageReference(param1);
      }
      
      public function getLineIndexAtPoint(param1:Number, param2:Number) : int
      {
         return _field.getLineIndexAtPoint(param1,param2);
      }
      
      public function getLineIndexOfChar(param1:int) : int
      {
         return _field.getLineIndexOfChar(param1);
      }
      
      public function getLineLength(param1:int) : int
      {
         return _field.getLineLength(param1);
      }
      
      public function getLineMetrics(param1:int) : TextLineMetrics
      {
         return _field.getLineMetrics(param1);
      }
      
      public function getLineOffset(param1:int) : int
      {
         return _field.getLineOffset(param1);
      }
      
      public function getLineText(param1:int) : String
      {
         return _field.getLineText(param1);
      }
      
      public function getParagraphLength(param1:int) : int
      {
         return _field.getParagraphLength(param1);
      }
      
      public function getTextFormat(param1:int = -1, param2:int = -1) : TextFormat
      {
         return _field.getTextFormat(param1,param2);
      }
      
      public function replaceText(param1:int, param2:int, param3:String) : void
      {
         _field.replaceText(param1,param2,param3);
         refreshTextImage();
      }
      
      public function setTextFormat(param1:TextFormat, param2:int = -1, param3:int = -1) : void
      {
         if(param2 >= 0 && param3 > param2 && param3 < _field.length)
         {
            _field.setTextFormat(param1,param2,param3);
            refreshTextImage();
         }
      }
      
      public function setTextMargins(param1:IMargins) : void
      {
         if(param1 != var_84)
         {
            var_84.dispose();
            var_84 = new TextMargins(param1.left,param1.top,param1.right,param1.bottom,setTextMargins);
         }
         if(var_543 == "left")
         {
            _field.width = var_29 - var_84.left - var_84.right;
         }
         refreshTextImage();
      }
      
      private function onTextStyleChanged(param1:Event) : void
      {
         setTextFormatting(this);
         refreshTextImage();
      }
      
      protected function parseVariableSet(param1:XML) : void
      {
         if(param1 != null)
         {
            var _loc2_:class_55 = new class_55();
            class_2468.parseVariableList(param1.children(),_loc2_);
            _drawing = true;
            for(var _loc4_ in _loc2_)
            {
               var _loc3_:Function = const_27[null];
            }
            _drawing = false;
         }
      }
      
      override public function set properties(param1:Array) : void
      {
         _drawing = true;
         for each(var _loc2_ in param1)
         {
            var _loc3_:Function = const_27[_loc2_.key];
         }
         _drawing = false;
         super.properties = param1;
         refreshTextImage();
      }
      
      override public function get properties() : Array
      {
         var _loc3_:Array = super.properties;
         var _loc2_:class_3109 = class_3398.getStyle(_textStyleName);
         _loc3_.push(createProperty("always_show_selection",_field.alwaysShowSelection));
         _loc3_.push(new PropertyStruct("antialias_type",_field.antiAliasType,"String",_field.antiAliasType != _loc2_.antiAliasType,class_2901.ANTIALIAS_TYPE_RANGE));
         _loc3_.push(createProperty("auto_size",var_543));
         _loc3_.push(createProperty("border",_field.border));
         _loc3_.push(createProperty("border_color",_field.borderColor));
         _loc3_.push(new PropertyStruct("etching_color",_etchingColor,"hex",_etchingColor != uint(_loc2_.etchingColor)));
         _loc3_.push(new PropertyStruct("etching_position",var_3040,"String",var_3040 != String(_loc2_.etchingPosition),class_2901.ETCHING_POSITION_RANGE));
         _loc3_.push(createProperty("condense_white",_field.condenseWhite));
         _loc3_.push(new PropertyStruct("font_face",defaultTextFormat.font,"String",defaultTextFormat.font != _loc2_.fontFamily));
         _loc3_.push(new PropertyStruct("font_size",defaultTextFormat.size,"uint",defaultTextFormat.size != _loc2_.fontSize));
         _loc3_.push(createProperty("grid_fit_type",_field.gridFitType));
         var _loc1_:uint = uint(_loc2_.color ?? getDefaultProperty("text_color").value);
         _loc3_.push(new PropertyStruct("text_color",_field.textColor,"hex",_field.textColor != _loc1_));
         _loc3_.push(createProperty("text_style",_textStyleName));
         _loc3_.push(createProperty("margin_left",var_84.left));
         _loc3_.push(createProperty("margin_top",var_84.top));
         _loc3_.push(createProperty("margin_right",var_84.right));
         _loc3_.push(createProperty("margin_bottom",var_84.bottom));
         _loc3_.push(createProperty("mouse_wheel_enabled",_field.mouseWheelEnabled));
         _loc3_.push(createProperty("max_chars",_field.maxChars));
         _loc3_.push(createProperty("multiline",_field.multiline));
         _loc3_.push(createProperty("restrict",_field.restrict));
         _loc3_.push(new PropertyStruct("sharpness",_field.sharpness,"Number",_field.sharpness != _loc2_.sharpness));
         _loc3_.push(new PropertyStruct("thickness",_field.thickness,"Number",_field.thickness != _loc2_.thickness));
         _loc3_.push(createProperty("word_wrap",_field.wordWrap));
         _loc3_.push(createProperty("max_lines",maxLines));
         _loc3_.push(createProperty("overflow_replace",overflowReplace));
         _loc3_.push(new PropertyStruct("bold",_field.defaultTextFormat.bold != false,"Boolean",_field.defaultTextFormat.bold != (_loc2_.fontWeight == "bold")));
         _loc3_.push(new PropertyStruct("italic",_field.defaultTextFormat.italic != false,"Boolean",_field.defaultTextFormat.italic != (_loc2_.fontStyle == "italic")));
         _loc3_.push(new PropertyStruct("underline",_field.defaultTextFormat.underline != false,"Boolean",_field.defaultTextFormat.underline != (_loc2_.textDecoration == "underline")));
         _loc3_.push(new PropertyStruct("kerning",_field.defaultTextFormat.kerning != false,"Boolean",_field.defaultTextFormat.kerning != _loc2_.kerning));
         _loc3_.push(new PropertyStruct("spacing",_field.defaultTextFormat.letterSpacing,"Number",_field.defaultTextFormat.letterSpacing != _loc2_.letterSpacing));
         _loc3_.push(new PropertyStruct("leading",_field.defaultTextFormat.leading,"Number",_field.defaultTextFormat.leading != _loc2_.leading));
         return _loc3_;
      }
      
      public function get etchingColor() : uint
      {
         return _etchingColor;
      }
      
      public function set etchingColor(param1:uint) : void
      {
         setEtchingColor(this,param1);
      }
      
      public function set styleSheet(param1:StyleSheet) : void
      {
         setStyleSheet(this,param1);
      }
      
      private function setStyleSheet(param1:TextController, param2:StyleSheet) : void
      {
         param1._field.styleSheet = param2;
         refreshTextImage();
      }
      
      public function get etchingPosition() : String
      {
         return var_3040;
      }
      
      public function set etchingPosition(param1:String) : void
      {
         setEtchingPosition(this,param1);
      }
      
      public function resetExplicitStyle() : void
      {
         var_310 = new class_3109();
      }
      
      public function get isOverflown() : Boolean
      {
         return var_1849;
      }
   }
}

