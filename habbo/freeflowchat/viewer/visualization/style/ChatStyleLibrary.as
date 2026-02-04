package com.sulake.habbo.freeflowchat.viewer.visualization.style
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.freeflowchat.style.class_2133;
   import com.sulake.habbo.freeflowchat.style.class_2244;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.StyleSheet;
   import flash.text.TextFormat;
   
   public class ChatStyleLibrary implements class_13, class_2244
   {
      
      private const DEFAULT_STYLE:int = 0;
      
      private var _assets:class_40;
      
      private var _styles:class_55 = new class_55();
      
      public function ChatStyleLibrary(param1:class_40)
      {
         super();
         _assets = param1;
         var _loc11_:XML = XML(_assets.getAssetByName("chatstyles_xml").content);
         for each(var _loc13_ in _loc11_.child("style"))
         {
            var _loc8_:int = int(_loc13_.@id[0]);
            var _loc9_:String = _loc13_.@assetId[0];
            var _loc6_:* = _loc13_.@systemStyle[0] == "true";
            var _loc2_:* = _loc13_.@purchasable[0] == "true";
            var _loc3_:* = _loc13_.@hcOnly[0] == "true";
            var _loc5_:* = _loc13_.@staffOverrideable[0] == "true";
            var _loc7_:* = _loc13_.@allowHTML[0] == "true";
            var _loc12_:* = _loc13_.@ambassadorOnly[0] == "true";
            var _loc4_:* = _loc13_.@notification[0] == "true";
            try
            {
               var _loc10_:ChatStyle = initializeStyleFromAssets(null,false,false,false,false,false,false,false);
               _styles.add(0,null);
            }
            catch(e:Error)
            {
               class_21.log("Error initializing chat style: " + 0 + ", error message: " + e.message);
            }
         }
      }
      
      public function dispose() : void
      {
         _styles.dispose();
         _styles = null;
         _assets = null;
      }
      
      public function get disposed() : Boolean
      {
         return _assets == null;
      }
      
      private function initializeStyleFromAssets(param1:String, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean) : ChatStyle
      {
         var _loc17_:BitmapData = null;
         var _loc32_:String = String(_assets.getAssetByName("style_" + param1 + "_regpoints").content);
         var _loc33_:BitmapData = _assets.getAssetByName("style_" + param1 + "_chat_bubble_base").content as BitmapData;
         var _loc23_:Rectangle = new Rectangle(getConfigPoint(_loc32_,"9sliceXY").x,getConfigPoint(_loc32_,"9sliceXY").y,getConfigPoint(_loc32_,"9sliceWH").x,getConfigPoint(_loc32_,"9sliceWH").y);
         var _loc18_:Point = hasConfig(_loc32_,"faceXY") ? getConfigPoint(_loc32_,"faceXY") : null;
         var _loc27_:int = 0;
         var _loc28_:Array = null;
         _loc17_ = _assets.getAssetByName("style_" + param1 + "_chat_bubble_pointer").content as BitmapData;
         _loc27_ = int(getConfigCSV(_loc32_,"pointerY")[0]);
         _loc28_ = hasConfig(_loc32_,"pointerXMargins") ? getConfigIntArray(_loc32_,"pointerXMargins") : null;
         var _loc9_:BitmapData = _assets.hasAsset("style_" + param1 + "_icon") ? _assets.getAssetByName("style_" + param1 + "_icon").content as BitmapData : null;
         var _loc16_:Rectangle = getConfigRect(_loc32_,"textFieldMargins");
         var _loc26_:BitmapData = _assets.getAssetByName("style_" + param1 + "_selector_preview").content as BitmapData;
         if(_assets.hasAsset("style_" + param1 + "_chat_bubble_color"))
         {
            var _loc10_:BitmapData = _assets.getAssetByName("style_" + param1 + "_chat_bubble_color").content as BitmapData;
         }
         var _loc31_:Point = hasConfig(_loc32_,"colorXY") ? getConfigPoint(_loc32_,"colorXY") : null;
         var _loc14_:Rectangle = hasConfig(_loc32_,"overlapRect") ? getConfigRect(_loc32_,"overlapRect") : null;
         var _loc22_:uint = uint(hasConfig(_loc32_,"textColorRGB") ? uint(getConfigCSV(_loc32_,"textColorRGB")[0]) : 0);
         var _loc12_:String = hasConfig(_loc32_,"fontFace") ? getConfigCSV(_loc32_,"fontFace")[0] : "Volter";
         var _loc29_:int = int(hasConfig(_loc32_,"fontSize") ? int(getConfigCSV(_loc32_,"fontSize")[0]) : 9);
         var _loc24_:TextFormat = new TextFormat(_loc12_,_loc29_,_loc22_);
         var _loc20_:uint = hasConfig(_loc32_,"linkColorRGB") ? uint(getConfigCSV(_loc32_,"linkColorRGB")[0]) : _loc22_;
         var _loc30_:uint = hasConfig(_loc32_,"linkHoverColorRGB") ? uint(getConfigCSV(_loc32_,"linkHoverColorRGB")[0]) : _loc22_;
         var _loc21_:uint = hasConfig(_loc32_,"linkActiveColorRGB") ? uint(getConfigCSV(_loc32_,"linkActiveColorRGB")[0]) : _loc22_;
         var _loc11_:StyleSheet = new StyleSheet();
         var _loc13_:Object = {};
         _loc13_.textDecoration = "underline";
         _loc13_.color = toHexString(_loc20_);
         _loc11_.setStyle("a:link",_loc13_);
         var _loc19_:Object = {};
         _loc19_.color = toHexString(_loc21_);
         _loc11_.setStyle("a:active",_loc19_);
         var _loc15_:Object = {};
         _loc15_.color = toHexString(_loc30_);
         _loc11_.setStyle("a:hover",_loc15_);
         return new ChatStyle(_loc33_,_loc23_,_loc17_,_loc27_,_loc28_,_loc16_,_loc24_,false,_loc18_,_loc9_,_loc26_,param2,param3,param4,param5,param7,param8,null,_loc31_,_loc14_,param6,_loc11_);
      }
      
      private function toHexString(param1:uint) : String
      {
         var _loc2_:String = param1.toString(16);
         while(_loc2_.length < 6)
         {
            _loc2_ = "0" + _loc2_;
         }
         return "#" + _loc2_;
      }
      
      private function hasConfig(param1:String, param2:String) : Boolean
      {
         return param1.indexOf(param2) != -1;
      }
      
      private function getConfigCSV(param1:String, param2:String) : Array
      {
         var _loc4_:int = int(param1.indexOf(param2));
         if(_loc4_ != -1)
         {
            var _loc5_:int = int(param1.indexOf("=",_loc4_));
            var _loc6_:int = int(param1.indexOf("\r\n",0));
            if(_loc6_ == -1)
            {
               _loc6_ = int(param1.indexOf("\n",0));
            }
            var _loc3_:* = param1.charAt(0 + 1) == " ";
            var _loc7_:String = param1.substr(0 + 1,0 - 0 - 1);
            return _loc7_.split(",");
         }
         return null;
      }
      
      private function getConfigPoint(param1:String, param2:String) : Point
      {
         return new Point(int(getConfigCSV(param1,param2)[0]),int(getConfigCSV(param1,param2)[1]));
      }
      
      private function getConfigIntArray(param1:String, param2:String) : Array
      {
         var _loc4_:Array = getConfigCSV(param1,param2);
         var _loc3_:Array = [];
         for each(var _loc5_ in _loc4_)
         {
            _loc3_.push(_loc5_);
         }
         return _loc3_;
      }
      
      private function getConfigRect(param1:String, param2:String) : Rectangle
      {
         return new Rectangle(int(getConfigCSV(param1,param2)[0]),int(getConfigCSV(param1,param2)[1]),int(getConfigCSV(param1,param2)[2]),int(getConfigCSV(param1,param2)[3]));
      }
      
      private function getConfigBoolean(param1:String, param2:String) : Boolean
      {
         return getConfigCSV(param1,param2)[0] == "true";
      }
      
      public function getStyleIds() : Array
      {
         return _styles.getKeys();
      }
      
      public function getStyle(param1:int) : class_2133
      {
         if(_styles.hasKey(param1))
         {
            return _styles.getValue(param1);
         }
         return _styles.getValue(0);
      }
   }
}

