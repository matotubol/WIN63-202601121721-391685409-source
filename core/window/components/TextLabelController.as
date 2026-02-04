package com.sulake.core.window.components
{
   import com.sulake.core.localization.ILocalizable;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.IMargins;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.TextFieldCache;
   import com.sulake.core.window.utils.TextMargins;
   import com.sulake.core.window.utils.class_3109;
   import com.sulake.core.window.utils.class_3398;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TextLabelController extends WindowController implements ILabelWindow, ILocalizable
   {
      
      private static const MARGINS_KEY:String = "margins";
      
      private var _textColor:Object = null;
      
      private var _textStyleName:String;
      
      private var _text:String = "";
      
      private var _localized:Boolean = false;
      
      private var var_84:TextMargins;
      
      private var var_5134:Number = 0;
      
      private var _textWidth:Number = 0;
      
      private var var_1899:Boolean = false;
      
      private var var_1534:Boolean = false;
      
      public function TextLabelController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         _textStyleName = String(param5.getWindowFactory().getThemeManager().getPropertyDefaults(param3).method_20("text_style"));
         class_3398.events.addEventListener("change",onTextStyleChanged);
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public function get antiAliasType() : String
      {
         return textField.antiAliasType;
      }
      
      public function get autoSize() : String
      {
         return textField.autoSize;
      }
      
      public function get bold() : Boolean
      {
         return textField.defaultTextFormat.bold;
      }
      
      public function get border() : Boolean
      {
         return textField.border;
      }
      
      public function get borderColor() : uint
      {
         return textField.borderColor;
      }
      
      public function get defaultTextFormat() : TextFormat
      {
         return textField.defaultTextFormat;
      }
      
      public function get embedFonts() : Boolean
      {
         return textField.embedFonts;
      }
      
      public function get fontFace() : String
      {
         return textField.defaultTextFormat.font;
      }
      
      public function get fontSize() : uint
      {
         return textField.defaultTextFormat.size == null ? 12 : uint(textField.defaultTextFormat.size);
      }
      
      public function get gridFitType() : String
      {
         return textField.gridFitType;
      }
      
      public function get italic() : Boolean
      {
         return textField.defaultTextFormat.italic;
      }
      
      public function get kerning() : Boolean
      {
         return textField.defaultTextFormat.kerning;
      }
      
      public function get length() : int
      {
         return _text.length;
      }
      
      public function get margins() : IMargins
      {
         if(!var_84)
         {
            var_84 = new TextMargins(0,0,0,0,setTextMargins);
         }
         return var_84;
      }
      
      public function get maxChars() : int
      {
         return textField.maxChars;
      }
      
      public function get sharpness() : Number
      {
         return textField.sharpness;
      }
      
      public function get spacing() : Number
      {
         return Number(textField.defaultTextFormat.letterSpacing);
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get textColor() : uint
      {
         return uint(_textColor);
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
         return var_5134;
      }
      
      public function get textWidth() : Number
      {
         return _textWidth;
      }
      
      public function get textStyle() : class_3109
      {
         return class_3398.getStyle(_textStyleName);
      }
      
      public function get thickness() : Number
      {
         return textField.thickness;
      }
      
      public function get underline() : Boolean
      {
         return textField.defaultTextFormat.underline;
      }
      
      public function get drawOffsetX() : int
      {
         return var_84 ? var_84.left : 0;
      }
      
      public function get drawOffsetY() : int
      {
         return var_84 ? var_84.top : 0;
      }
      
      public function get hasTextColor() : Boolean
      {
         return _textColor != null;
      }
      
      protected function get textField() : TextField
      {
         var _loc1_:TextField = TextFieldCache.getTextFieldByStyleName(_textStyleName);
         if(_loc1_)
         {
            _loc1_.text = _text;
            if(_textColor != null)
            {
               _loc1_.textColor = uint(_textColor);
            }
         }
         return _loc1_;
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
         if(_caption.charAt(0) == "$" && _caption.charAt(1) == "{")
         {
            context.registerLocalizationListener(_caption.slice(2,_caption.indexOf("}")),this);
            _localized = true;
         }
         else
         {
            _text = param1;
            refresh();
         }
      }
      
      override public function set caption(param1:String) : void
      {
         text = param1;
      }
      
      public function set localization(param1:String) : void
      {
         if(param1 != null)
         {
            _text = param1;
            refresh();
         }
      }
      
      public function set textStyle(param1:class_3109) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_textStyleName != param1.name)
         {
            _textStyleName = param1.name;
            refresh();
         }
      }
      
      public function set textColor(param1:uint) : void
      {
         if(param1 != _textColor)
         {
            _textColor = param1;
            refresh();
         }
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            class_3398.events.removeEventListener("change",onTextStyleChanged);
            if(_localized)
            {
               _localized = false;
               context.removeLocalizationListener(_caption.slice(2,_caption.indexOf("}")),this);
            }
            if(var_84)
            {
               var_84.dispose();
               var_84 = null;
            }
            super.dispose();
         }
      }
      
      private function refresh(param1:Boolean = false) : void
      {
         if(var_1899)
         {
            return;
         }
         var_1899 = true;
         var _loc3_:TextField = textField;
         if(!_loc3_)
         {
            var_1899 = false;
            return;
         }
         _textWidth = _loc3_.textWidth;
         var_5134 = _loc3_.textHeight;
         var _loc9_:int = _loc3_.border ? 1 : 0;
         var _loc11_:int = var_84 ? var_84.left + var_84.right : 0;
         var _loc10_:int = var_84 ? var_84.top + var_84.bottom : 0;
         var _loc4_:int = var_29 - 0;
         var _loc8_:int = var_32 - _loc10_;
         var _loc2_:int = Math.floor(_loc3_.width) + _loc9_;
         var _loc6_:int = Math.floor(_loc3_.height) + _loc9_;
         var _loc5_:Boolean = false;
         if(var_1534)
         {
            if(_loc2_ != _loc8_)
            {
               setRectangle(var_25,var_26,_loc6_ + 0,Math.floor(_loc3_.width) + _loc10_);
               _loc5_ = true;
            }
            if(_loc6_ < _loc4_)
            {
               _loc3_.height = _loc4_ - _loc9_;
            }
            else if(_loc6_ > _loc4_)
            {
               setRectangle(var_25,var_26,_loc6_ + 0,Math.floor(_loc3_.width) + _loc10_);
               _loc5_ = true;
            }
         }
         else
         {
            if(_loc2_ != _loc4_)
            {
               setRectangle(var_25,var_26,_loc2_ + 0,Math.floor(_loc3_.height) + _loc10_);
               _loc5_ = true;
            }
            if(_loc6_ < _loc8_)
            {
               _loc3_.height = _loc8_ - _loc9_;
            }
            else if(_loc6_ > _loc8_)
            {
               setRectangle(var_25,var_26,_loc2_ + 0,Math.floor(_loc3_.height) + _loc10_);
               _loc5_ = true;
            }
         }
         var_1899 = false;
         _context.invalidate(this,null,1);
         if(!_loc5_ && !param1 && name_1)
         {
            var _loc7_:class_1758 = class_1758.allocate("WE_RESIZED",this,null);
            name_1.dispatchEvent(null);
            null.recycle();
         }
      }
      
      private function setTextMargins(param1:IMargins) : void
      {
         if(param1 && param1 != var_84)
         {
            if(var_84)
            {
               var_84.assign(param1.left,param1.top,param1.right,param1.bottom,setTextMargins);
            }
            else
            {
               var_84 = new TextMargins(param1.left,param1.top,param1.right,param1.bottom,setTextMargins);
            }
         }
         refresh();
      }
      
      private function onTextStyleChanged(param1:Event) : void
      {
         refresh();
      }
      
      private function setTextMarginMap(param1:class_55) : void
      {
         if(var_84)
         {
            var_84.assign(int(param1["left"]),int(param1["top"]),int(param1["right"]),int(param1["bottom"]),setTextMargins);
         }
         else
         {
            var_84 = new TextMargins(int(param1["left"]),int(param1["top"]),int(param1["right"]),int(param1["bottom"]),setTextMargins);
         }
         refresh();
      }
      
      override public function get properties() : Array
      {
         var _loc3_:Array = super.properties;
         var _loc2_:class_3109 = class_3398.getStyle(_textStyleName);
         _loc3_.push(createProperty("text_style",_textStyleName));
         var _loc1_:uint = uint(_loc2_.color ?? getDefaultProperty("text_color").value);
         _loc3_.push(new PropertyStruct("text_color",_textColor == null ? _loc1_ : _textColor,"hex",_textColor != null && _textColor != _loc1_));
         _loc3_.push(createProperty("vertical",var_1534));
         if(var_84 != null)
         {
            _loc3_.push(createProperty("margin_left",var_84.left));
            _loc3_.push(createProperty("margin_top",var_84.top));
            _loc3_.push(createProperty("margin_right",var_84.right));
            _loc3_.push(createProperty("margin_bottom",var_84.bottom));
         }
         else
         {
            _loc3_.push(getDefaultProperty("margin_left"));
            _loc3_.push(getDefaultProperty("margin_top"));
            _loc3_.push(getDefaultProperty("margin_right"));
            _loc3_.push(getDefaultProperty("margin_bottom"));
         }
         return _loc3_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "text_style":
                  textStyle = class_3398.getStyle(_loc2_.value as String);
                  break;
               case "text_color":
                  _textColor = _loc2_.value as uint;
                  break;
               case "margin_left":
                  if(var_84 != null || _loc2_.valid)
                  {
                     margins.left = _loc2_.value as int;
                  }
                  break;
               case "margin_top":
                  if(var_84 != null || _loc2_.valid)
                  {
                     margins.top = _loc2_.value as int;
                  }
                  break;
               case "margin_right":
                  if(var_84 != null || _loc2_.valid)
                  {
                     margins.right = _loc2_.value as int;
                  }
                  break;
               case "margin_bottom":
                  if(var_84 != null || _loc2_.valid)
                  {
                     margins.bottom = _loc2_.value as int;
                  }
                  break;
               case "margins":
                  setTextMarginMap(_loc2_.value as class_55);
                  break;
               case "vertical":
                  vertical = _loc2_.value as Boolean;
            }
         }
         super.properties = param1;
      }
      
      public function get vertical() : Boolean
      {
         return var_1534;
      }
      
      public function set vertical(param1:Boolean) : void
      {
         var_1534 = param1;
         refresh();
      }
   }
}

