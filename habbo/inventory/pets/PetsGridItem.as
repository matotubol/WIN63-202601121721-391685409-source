package com.sulake.habbo.inventory.pets
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
   import package_105.class_2838;
   
   public class PetsGridItem
   {
      
      private static const THUMB_COLOR_NORMAL:int = 13421772;
      
      private static const THUMB_COLOR_UNSEEN:int = 10275685;
      
      private var var_311:class_2838;
      
      private var _window:class_1812;
      
      private var _assets:class_40;
      
      private var var_978:class_1741;
      
      private var var_2281:Boolean;
      
      private var var_2267:PetsView;
      
      private var var_3108:int = -1;
      
      private var var_1994:Boolean;
      
      private var _isUnseen:Boolean;
      
      public function PetsGridItem(param1:PetsView, param2:class_2838, param3:class_38, param4:class_40, param5:Boolean)
      {
         super();
         if(param1 == null || param2 == null || param3 == null || param4 == null)
         {
            return;
         }
         _assets = param4;
         var_2267 = param1;
         var_311 = param2;
         _isUnseen = param5;
         var _loc8_:XmlAsset = param4.getAssetByName("inventory_thumb_xml") as XmlAsset;
         if(_loc8_ == null || _loc8_.content == null)
         {
            return;
         }
         _window = param3.buildFromXML(_loc8_.content as XML) as class_1812;
         _window.procedure = eventHandler;
         var _loc7_:int = 64;
         var _loc11_:int = 3;
         var _loc9_:Boolean = false;
         var _loc6_:String = null;
         if(param2.typeId == 15)
         {
            _loc7_ = 32;
            _loc11_ = 2;
            _loc9_ = true;
         }
         else if(param2.typeId == 35)
         {
            _loc7_ = 64;
            _loc11_ = 3;
            _loc9_ = true;
         }
         else if(param2.typeId == 26 || param2.typeId == 27)
         {
            _loc7_ = 32;
            _loc11_ = 3;
            _loc9_ = true;
         }
         else if(param2.typeId == 16)
         {
            _loc7_ = 32;
            _loc11_ = 2;
            _loc9_ = true;
            if(param2.level >= 7)
            {
               _loc6_ = "std";
            }
            else
            {
               _loc6_ = "grw" + param2.level;
            }
         }
         var _loc10_:BitmapData = param1.getPetImage(param2,_loc11_,_loc9_,this,_loc7_,_loc6_);
         setPetImage(_loc10_);
         updateStatusGraphics();
      }
      
      public function dispose() : void
      {
         _assets = null;
         var_2267 = null;
         var_311 = null;
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
               var_2267.setSelectedGridItem(this);
               var_1994 = true;
               break;
            case "WME_UP":
               var_1994 = false;
               break;
            case "WME_OUT":
               if(var_1994)
               {
                  var_1994 = false;
                  var_2267.placePetToRoom(var_311.id,true);
               }
         }
      }
      
      public function setPetImage(param1:BitmapData) : void
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
      
      public function get pet() : class_2838
      {
         return var_311;
      }
      
      public function set imageDownloadId(param1:int) : void
      {
         var_3108 = param1;
      }
      
      public function get imageDownloadId() : int
      {
         return var_3108;
      }
   }
}

