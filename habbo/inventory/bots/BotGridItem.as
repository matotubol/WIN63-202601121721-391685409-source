package com.sulake.habbo.inventory.bots
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.class_3317;
   
   public class BotGridItem
   {
      
      private static const THUMB_COLOR_NORMAL:int = 13421772;
      
      private static const THUMB_COLOR_UNSEEN:int = 10275685;
      
      private var var_24:class_3317;
      
      private var _window:class_1812;
      
      private var _assets:class_40;
      
      private var var_978:class_1741;
      
      private var var_2281:Boolean;
      
      private var var_18:BotsView;
      
      private var var_3108:int = -1;
      
      private var var_1994:Boolean;
      
      private var _isUnseen:Boolean;
      
      public function BotGridItem(param1:BotsView, param2:class_3317, param3:class_38, param4:class_40, param5:Boolean)
      {
         super();
         if(param1 == null || param2 == null || param3 == null || param4 == null)
         {
            return;
         }
         _assets = param4;
         var_18 = param1;
         var_24 = param2;
         _isUnseen = param5;
         var _loc7_:XmlAsset = param4.getAssetByName("inventory_thumb_xml") as XmlAsset;
         if(_loc7_ == null || _loc7_.content == null)
         {
            return;
         }
         _window = param3.buildFromXML(_loc7_.content as XML) as class_1812;
         _window.procedure = eventHandler;
         var _loc6_:BitmapData = param1.getGridItemImage(param2);
         setImage(_loc6_);
         updateStatusGraphics();
      }
      
      public function dispose() : void
      {
         _assets = null;
         var_18 = null;
         var_24 = null;
         var_978 = null;
         var_3108 = -1;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function eventHandler(param1:class_1758, param2:class_1741) : void
      {
         switch(param1.type)
         {
            case "WME_DOWN":
               var_18.setSelectedGridItem(this);
               var_1994 = true;
               break;
            case "WME_UP":
               var_1994 = false;
               break;
            case "WME_OUT":
               if(var_1994)
               {
                  var_1994 = false;
                  var_18.placeItemToRoom(var_24.id,true);
               }
         }
      }
      
      public function setImage(param1:BitmapData) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc3_:class_2251 = _window.findChildByName("bitmap") as class_2251;
         var _loc2_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height);
         _loc2_.fillRect(_loc2_.rect,0);
         _loc2_.copyPixels(param1,param1.rect,new Point(_loc2_.width / 2 - param1.width / 2,_loc2_.height / 2 - param1.height / 2));
         if(_loc3_.bitmap)
         {
            _loc3_.bitmap.dispose();
         }
         _loc3_.bitmap = _loc2_;
      }
      
      public function setUnseen(param1:Boolean) : void
      {
         if(_isUnseen != param1)
         {
            _isUnseen = param1;
            updateStatusGraphics();
         }
      }
      
      public function setSelected(param1:Boolean) : void
      {
         if(var_2281 != param1)
         {
            var_2281 = param1;
            if(!_window || !var_978)
            {
               return;
            }
            updateStatusGraphics();
         }
      }
      
      private function updateStatusGraphics() : void
      {
         var _loc1_:class_1741 = _window.findChildByName("outline");
         if(_loc1_ != null)
         {
            _loc1_.visible = var_2281;
         }
         if(!var_978)
         {
            var_978 = _window.findChildByTag("BG_COLOR");
         }
         var_978.color = _isUnseen ? 10275685 : 13421772;
      }
      
      public function get window() : class_1741
      {
         return _window;
      }
      
      public function get data() : class_3317
      {
         return var_24;
      }
   }
}

