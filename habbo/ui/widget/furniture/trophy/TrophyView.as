package com.sulake.habbo.ui.widget.furniture.trophy
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   
   public class TrophyView implements ITrophyView
   {
      
      private static const BG_IMAGE_LIST:Array = new Array("trophy_bg_gold","trophy_bg_silver","trophy_bg_bronze");
      
      private static const BG_COLOR_LIST:Array = new Array(4293707079,4291411404,4290279476);
      
      private var var_16:ITrophyFurniWidget;
      
      private var _window:class_1812;
      
      public function TrophyView(param1:ITrophyFurniWidget)
      {
         super();
         var_16 = param1;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_16 = null;
      }
      
      public function showInterface() : Boolean
      {
         var _loc2_:class_1741 = null;
         var _loc9_:class_1812 = null;
         var _loc6_:ITextWindow = null;
         var _loc3_:ITextWindow = null;
         var _loc7_:ITextWindow = null;
         var _loc5_:BitmapDataAsset = null;
         var _loc4_:BitmapData = null;
         var _loc8_:class_2251 = null;
         var _loc10_:IAsset = var_16.assets.getAssetByName("trophy");
         var _loc1_:XmlAsset = XmlAsset(_loc10_);
         if(_loc1_ == null)
         {
            return false;
         }
         if(_window == null)
         {
            _window = var_16.windowManager.buildFromXML(_loc1_.content as XML) as class_1812;
         }
         _window.center();
         _loc2_ = _window.findChildByName("close");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc9_ = _window.findChildByName("title_bg") as class_1812;
         if(_loc9_ != null)
         {
            _loc9_.color = BG_COLOR_LIST[var_16.color];
         }
         _loc6_ = _window.findChildByName("greeting") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.text = var_16.message.replace(/\\r/g,"\n");
         }
         _loc3_ = _window.findChildByName("date") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = var_16.date;
         }
         _loc7_ = _window.findChildByName("name") as ITextWindow;
         if(_loc7_ != null)
         {
            _loc7_.text = var_16.name;
         }
         _loc5_ = var_16.assets.getAssetByName(BG_IMAGE_LIST[var_16.color]) as BitmapDataAsset;
         _loc8_ = _window.findChildByName("trophy_bg") as class_2251;
         if(_loc5_ != null)
         {
            _loc4_ = _loc5_.content as BitmapData;
            _loc8_.bitmap = _loc4_;
         }
         return true;
      }
      
      public function disposeInterface() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         disposeInterface();
      }
   }
}

