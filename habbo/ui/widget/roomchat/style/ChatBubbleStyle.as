package com.sulake.habbo.ui.widget.roomchat.style
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   
   public class ChatBubbleStyle
   {
      
      private var var_3109:int;
      
      private var _styleName:String;
      
      private var var_4291:Boolean = false;
      
      private var var_4479:Boolean = false;
      
      private var _normalLayout:IRegionWindow;
      
      private var _whisperLayout:IRegionWindow;
      
      private var _shoutLayout:IRegionWindow;
      
      private var var_4207:BitmapData;
      
      private var var_4722:BitmapData;
      
      private var var_4413:BitmapData;
      
      private var var_4365:BitmapData;
      
      private var var_3925:BitmapData;
      
      private var var_4547:BitmapData;
      
      public function ChatBubbleStyle(param1:class_40, param2:class_38, param3:XML)
      {
         super();
         var_3109 = param3.@id[0];
         _styleName = param3.@name[0];
         var_4291 = param3.@systemstyle[0];
         var_4479 = param3.@staffoverride[0];
         var _loc11_:XML = param3.child("layouts")[0];
         var _loc4_:XML = param3.child("bitmaps")[0];
         _normalLayout = buildBubbleWindow(param2,param1,getXmlElementAssetId(_loc11_,"speakLayout"));
         _whisperLayout = buildBubbleWindow(param2,param1,getXmlElementAssetId(_loc11_,"whisperLayout"));
         _shoutLayout = buildBubbleWindow(param2,param1,getXmlElementAssetId(_loc11_,"shoutLayout"));
         var _loc9_:String = getXmlElementAssetId(_loc4_,"leftBitmap");
         var _loc6_:String = getXmlElementAssetId(_loc4_,"leftColorBitmap");
         var _loc7_:String = getXmlElementAssetId(_loc4_,"middleBitmap");
         var _loc5_:String = getXmlElementAssetId(_loc4_,"rightBitmap");
         var _loc10_:String = getXmlElementAssetId(_loc4_,"pointerBitmap");
         if(_loc9_)
         {
            var_4207 = getBitmapDataFor(_loc9_,param1);
         }
         if(_loc6_)
         {
            var_4722 = getBitmapDataFor(_loc6_,param1);
         }
         if(_loc7_)
         {
            var_4413 = getBitmapDataFor(_loc7_,param1);
         }
         if(_loc5_)
         {
            var_4365 = getBitmapDataFor(_loc5_,param1);
         }
         if(_loc10_)
         {
            var_3925 = getBitmapDataFor(_loc10_,param1);
         }
         var _loc8_:String = getXmlElementAssetId(_loc4_,"previewIconBitmap");
         if(_loc8_)
         {
            var_4547 = getBitmapDataFor(_loc8_,param1);
         }
      }
      
      private static function getXmlElementAssetId(param1:XML, param2:String) : String
      {
         var _loc3_:XMLList = param1.child(param2);
         if(_loc3_.length() < 1)
         {
            return null;
         }
         var _loc4_:XMLList = XML(_loc3_[0]).attribute("assetId");
         if(_loc4_.length() < 1)
         {
            return null;
         }
         return _loc4_[0];
      }
      
      public function get normalLayout() : IRegionWindow
      {
         return _normalLayout;
      }
      
      public function get whisperLayout() : IRegionWindow
      {
         return _whisperLayout;
      }
      
      public function get shoutLayout() : IRegionWindow
      {
         return _shoutLayout;
      }
      
      public function get leftBitmapData() : BitmapData
      {
         return var_4207;
      }
      
      public function get leftColorBitmapData() : BitmapData
      {
         return var_4722;
      }
      
      public function get middleBitmapData() : BitmapData
      {
         return var_4413;
      }
      
      public function get rightBitmapData() : BitmapData
      {
         return var_4365;
      }
      
      public function get pointerBitmapData() : BitmapData
      {
         return var_3925;
      }
      
      public function get isSystemStyle() : Boolean
      {
         return var_4291;
      }
      
      public function get isStaffOverrideable() : Boolean
      {
         return var_4479;
      }
      
      public function get selectorPreviewIconBitmapData() : BitmapData
      {
         return var_4547;
      }
      
      private function buildBubbleWindow(param1:class_38, param2:class_40, param3:String) : IRegionWindow
      {
         if(param3 == null)
         {
            return null;
         }
         var _loc5_:IAsset = param2.getAssetByName(localAssetName(param3 + "_xml"));
         var _loc4_:IRegionWindow = param1.buildFromXML(_loc5_.content as XML,1) as IRegionWindow;
         _loc4_.tags.push("roomchat_bubble");
         _loc4_.x = 0;
         _loc4_.y = 0;
         _loc4_.width = 0;
         _loc4_.background = true;
         _loc4_.mouseThreshold = 0;
         _loc4_.setParamFlag(1073741824,true);
         return _loc4_;
      }
      
      private function localAssetName(param1:String) : String
      {
         return "roomchat_styles_" + _styleName + "_" + param1;
      }
      
      private function getBitmapDataFor(param1:String, param2:class_40) : BitmapData
      {
         var _loc3_:IAsset = param2.getAssetByName(localAssetName(param1));
         if(_loc3_)
         {
            return BitmapData(_loc3_.content);
         }
         throw new Error("Configured bitmapdata asset missing for chat bubble style: " + localAssetName(param1));
      }
   }
}

