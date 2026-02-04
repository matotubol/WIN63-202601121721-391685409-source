package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.class_55;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.text.StyleSheet;
   
   public class class_3398
   {
      
      public static const REGULAR:String = "regular";
      
      public static const ITALIC:String = "italic";
      
      public static const BOLD:String = "bold";
      
      private static var var_214:class_55;
      
      private static var var_1279:Array;
      
      private static var var_450:IEventDispatcher;
      
      private static const TAG_OPEN:String = "{";
      
      private static const TAG_CLOSE:String = "}";
      
      private static const CMT_OPEN:String = "/*";
      
      private static const CMT_CLOSE:String = "*/";
      
      init();
      
      public function class_3398()
      {
         super();
      }
      
      public static function get events() : IEventDispatcher
      {
         return var_450;
      }
      
      private static function init() : void
      {
         var_214 = new class_55();
         var_1279 = [];
         var_450 = new EventDispatcherWrapper();
         var _loc1_:class_3109 = new class_3109();
         null.name = "regular";
         null.color = 0;
         null.fontSize = "9";
         null.fontFamily = "Courier";
         null.fontStyle = "normal";
         null.fontWeight = "normal";
         var_214[null.name] = null;
         var_1279.push(null.name);
         _loc1_ = new class_3109();
         null.name = "italic";
         null.color = 0;
         null.fontSize = "9";
         null.fontFamily = "Courier";
         null.fontStyle = "italic";
         null.fontWeight = "normal";
         var_214[null.name] = null;
         var_1279.push(null.name);
         _loc1_ = new class_3109();
         null.name = "bold";
         null.color = 0;
         null.fontSize = "9";
         null.fontFamily = "Courier";
         null.fontStyle = "normal";
         null.fontWeight = "bold";
         var_214[null.name] = null;
         var_1279.push(null.name);
      }
      
      public static function getStyle(param1:String) : class_3109
      {
         return var_214[param1];
      }
      
      public static function getStyleWithIndex(param1:int) : class_3109
      {
         return var_214.getWithIndex(param1);
      }
      
      public static function setStyle(param1:String, param2:class_3109) : void
      {
         var _loc3_:* = !var_214.hasKey(param1);
         param2.name = param1;
         var_214[param1] = param2;
         if(_loc3_)
         {
            var_1279.push(param1);
            var_450.dispatchEvent(new Event("added"));
         }
         else
         {
            var_450.dispatchEvent(new Event("change"));
         }
      }
      
      public static function setStyles(param1:Array, param2:Boolean = false) : void
      {
         var _loc3_:Array = null;
         if(param2)
         {
            _loc3_ = [var_214["regular"],var_214["italic"],var_214["bold"]];
            var_214.reset();
            var_214["regular"] = _loc3_[0];
            var_214["italic"] = _loc3_[1];
            var_214["bold"] = _loc3_[2];
         }
         var _loc4_:int = int(var_214.length);
         for each(var _loc5_ in param1)
         {
            var_214[_loc5_.name] = _loc5_;
            if(var_1279.indexOf(_loc5_.name) == -1)
            {
               var_1279.push(_loc5_.name);
            }
         }
         var_450.dispatchEvent(new Event("change"));
         if(var_214.length != _loc4_)
         {
            var_450.dispatchEvent(new Event("added"));
         }
      }
      
      public static function findMatchingTextStyle(param1:String) : class_3109
      {
         var _loc3_:class_3109 = parseCSS(param1)[0] as class_3109;
         if(_loc3_)
         {
            var _loc2_:class_3109 = var_214[_loc3_.name];
         }
         return null;
      }
      
      public static function enumerateStyles() : Array
      {
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:int = int(var_214.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.push(var_214.getWithIndex(_loc3_));
            _loc3_++;
         }
         return _loc1_;
      }
      
      public static function enumerateStyleNames() : Array
      {
         return var_214.getKeys();
      }
      
      public static function getStyleNameArrayRef() : Array
      {
         return var_1279;
      }
      
      public static function parseCSS(param1:String) : Array
      {
         var _loc7_:Object = null;
         var _loc6_:class_3109 = null;
         var _loc5_:StyleSheet = new StyleSheet();
         _loc5_.parseCSS(param1);
         var _loc3_:Array = parseStyleNamesFromCSS(param1);
         var _loc2_:Array = [];
         for each(var _loc4_ in _loc3_)
         {
            _loc7_ = _loc5_.getStyle(_loc4_);
            _loc6_ = new class_3109();
            _loc6_.name = _loc4_;
            _loc6_.color = _loc7_.color ? uint(String(_loc7_.color).replace("#","0x")) : null;
            _loc6_.fontFamily = _loc7_.fontFamily ? _loc7_.fontFamily : null;
            _loc6_.fontSize = _loc7_.fontSize ? parseInt(String(_loc7_.fontSize)) : null;
            _loc6_.fontStyle = _loc7_.fontStyle ? _loc7_.fontStyle : null;
            _loc6_.fontWeight = _loc7_.fontWeight ? _loc7_.fontWeight : null;
            _loc6_.kerning = _loc7_.kerning ? _loc7_.kerning == "true" : null;
            _loc6_.leading = _loc7_.leading ? parseInt(String(_loc7_.leading)) : null;
            _loc6_.letterSpacing = _loc7_.letterSpacing ? parseInt(_loc7_.letterSpacing.toString()) : null;
            _loc6_.textDecoration = _loc7_.textDecoration ? _loc7_.textDecoration : null;
            _loc6_.textIndent = _loc7_.textIndent ? parseInt(_loc7_.textIndent.toString()) : null;
            _loc6_.antiAliasType = _loc7_.antiAliasType ? _loc7_.antiAliasType : null;
            _loc6_.sharpness = _loc7_.sharpness ? parseInt(_loc7_.sharpness) : null;
            _loc6_.thickness = _loc7_.thickness ? parseInt(_loc7_.thickness) : null;
            _loc6_.etchingColor = _loc7_.etchingColor ? uint(String(_loc7_.etchingColor).replace("#","0x")) : null;
            _loc6_.etchingPosition = _loc7_.etchingPosition ? String(_loc7_.etchingPosition) : null;
            _loc2_.push(_loc6_);
         }
         return _loc2_;
      }
      
      private static function parseStyleNamesFromCSS(param1:String) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:String = param1;
         _loc3_ = _loc3_.split("\t").join("");
         _loc3_ = _loc3_.split("\n").join("");
         _loc3_ = _loc3_.split("\r").join("");
         var _loc4_:Array = _loc3_.split("}");
         if(countSubStrings(param1,"{") != countSubStrings(param1,"}"))
         {
            throw new Error("Mismatching amount of \"{\" versus \"}\", please check the CSS!");
         }
         for each(var _loc5_ in _loc4_)
         {
            while(_loc5_.indexOf("/*") == 0)
            {
               _loc5_ = _loc5_.substring(_loc5_.indexOf("*/") + 2,_loc5_.length);
            }
            _loc5_ = _loc5_.slice(0,_loc5_.indexOf("{")).split(" ").join("");
            if(_loc5_.length)
            {
               _loc2_.push(_loc5_);
            }
         }
         return _loc2_;
      }
      
      private static function countSubStrings(param1:String, param2:String) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(true)
         {
            _loc4_ = int(param1.indexOf(param2,_loc4_));
            if(_loc4_ == -1)
            {
               break;
            }
            _loc4_++;
            _loc3_++;
         }
         return _loc3_;
      }
      
      public static function toString() : String
      {
         var _loc2_:Array = enumerateStyles();
         var _loc1_:String = "";
         for each(var _loc3_ in _loc2_)
         {
            _loc1_ += _loc3_.toString() + "\n\n";
         }
         return _loc1_;
      }
   }
}

