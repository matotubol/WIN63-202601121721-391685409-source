package com.sulake.habbo.inventory.effects
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.common.IThumbListDataProvider;
   import com.sulake.habbo.inventory.common.ThumbListManager;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class EffectsView implements IInventoryView
   {
      
      private var _windowManager:class_38;
      
      private var var_909:class_40;
      
      private var var_18:class_1812;
      
      private var var_36:EffectsModel;
      
      private var var_1413:ThumbListManager;
      
      private var var_1445:ThumbListManager;
      
      private var _disposed:Boolean = false;
      
      public function EffectsView(param1:EffectsModel, param2:class_38, param3:class_40, param4:class_27, param5:IThumbListDataProvider, param6:IThumbListDataProvider)
      {
         super();
         var_36 = param1;
         var_909 = param3;
         _windowManager = param2;
         var _loc9_:IAsset = var_909.getAssetByName("inventory_effects_xml");
         var _loc7_:XmlAsset = XmlAsset(_loc9_);
         var_18 = class_1812(_windowManager.buildFromXML(XML(_loc7_.content)));
         var_18.visible = false;
         var_18.procedure = windowEventProc;
         var_1413 = new ThumbListManager(var_909,param5,"thumb_bg_png","thumb_bg_selected_png",getActiveThumbListImageWidth(),getActiveThumbListImageHeight());
         var_1445 = new ThumbListManager(var_909,param6,"thumb_bg_png","thumb_bg_selected_png",getActiveThumbListImageWidth(),getActiveThumbListImageHeight());
         var _loc10_:class_2251 = var_18.findChildByName("active_items_image") as class_2251;
         _loc10_.procedure = activeThumbListEventProc;
         var _loc8_:class_2251 = var_18.findChildByName("inactive_items_image") as class_2251;
         _loc8_.procedure = inactiveThumbListEventProc;
         var_18.procedure = windowEventProc;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _windowManager = null;
            var_36 = null;
            var_18 = null;
            if(var_1413 != null)
            {
               var_1413.dispose();
               var_1413 = null;
            }
            if(var_1445 != null)
            {
               var_1445.dispose();
               var_1445 = null;
            }
            _disposed = true;
         }
      }
      
      public function getActiveThumbListImageWidth() : int
      {
         var _loc1_:class_2251 = var_18.findChildByName("active_items_image") as class_2251;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.width;
      }
      
      public function getActiveThumbListImageHeight() : int
      {
         var _loc1_:class_2251 = var_18.findChildByName("active_items_image") as class_2251;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.height;
      }
      
      public function getInactiveThumbListImageWidth() : int
      {
         var _loc1_:class_2251 = var_18.findChildByName("inactive_items_image") as class_2251;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.width;
      }
      
      public function getInactiveThumbListImageHeight() : int
      {
         var _loc1_:class_2251 = var_18.findChildByName("inactive_items_image") as class_2251;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.height;
      }
      
      public function getWindowContainer() : class_1812
      {
         if(var_18 == null)
         {
            return null;
         }
         if(var_18.disposed)
         {
            return null;
         }
         return var_18;
      }
      
      public function updateListViews() : void
      {
         if(var_18 == null)
         {
            return;
         }
         if(var_18.disposed)
         {
            return;
         }
         var_1445.updateImageFromList();
         var_1413.updateImageFromList();
         var _loc2_:class_2251 = var_18.findChildByName("inactive_items_image") as class_2251;
         var _loc4_:BitmapData = var_1445.getListImage();
         _loc2_.bitmap = _loc4_;
         _loc2_.width = _loc4_.width;
         _loc2_.height = _loc4_.height;
         _loc2_.invalidate();
         var _loc3_:class_2251 = var_18.findChildByName("active_items_image") as class_2251;
         var _loc1_:BitmapData = var_1413.getListImage();
         _loc3_.bitmap = _loc1_;
         _loc3_.width = _loc1_.width;
         _loc3_.height = _loc1_.height;
         _loc3_.invalidate();
      }
      
      public function updateActionView() : void
      {
         if(var_18 == null)
         {
            return;
         }
         if(var_18.disposed)
         {
            return;
         }
         var _loc2_:class_1775 = var_18.findChildByName("activateEffect_button") as class_1775;
         var _loc3_:ITextWindow = var_18.findChildByName("effectDescriptionText") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc3_ == null)
         {
            return;
         }
         var _loc1_:Effect = var_36.getSelectedEffect(-1);
         if(_loc1_ == null)
         {
            _loc2_.disable();
            setEffectDescriptionImage(null);
            _loc3_.text = "${inventory.effects.defaultdescription}";
         }
         else if(_loc1_.isActive)
         {
            _loc2_.disable();
            setEffectDescriptionImage(_loc1_.iconImage);
            _loc3_.text = "${inventory.effects.active}";
            _windowManager.registerLocalizationParameter("inventory.effects.active","timeleft",convertSecondsToTime(_loc1_.secondsLeft));
            _windowManager.registerLocalizationParameter("inventory.effects.active","duration",convertSecondsToTime(_loc1_.duration));
            _windowManager.registerLocalizationParameter("inventory.effects.active","itemcount",String(_loc1_.amountInInventory));
         }
         else
         {
            _loc2_.enable();
            setEffectDescriptionImage(_loc1_.iconImage);
            _loc3_.text = "${inventory.effects.inactive}";
            _windowManager.registerLocalizationParameter("inventory.effects.inactive","duration",convertSecondsToTime(_loc1_.duration));
            _windowManager.registerLocalizationParameter("inventory.effects.inactive","itemcount",String(_loc1_.amountInInventory));
         }
      }
      
      private function setEffectDescriptionImage(param1:BitmapData) : void
      {
         if(var_18 == null)
         {
            return;
         }
         if(var_18.disposed)
         {
            return;
         }
         var _loc3_:class_2251 = var_18.findChildByName("effectDescriptionImage") as class_2251;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.bitmap == null)
         {
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,false);
         }
         if(param1 == null)
         {
            param1 = new BitmapData(_loc3_.width,_loc3_.height);
         }
         var _loc2_:Point = new Point((_loc3_.width - param1.width) / 2,(_loc3_.height - param1.height) / 2);
         _loc3_.bitmap.copyPixels(param1,param1.rect,_loc2_,null,null,false);
         _loc3_.invalidate();
      }
      
      private function convertSecondsToTime(param1:int) : String
      {
         var _loc2_:int = Math.floor(param1 / 60 / 60);
         var _loc4_:int = Math.floor((param1 - _loc2_ * 60 * 60) / 60);
         var _loc3_:int = param1 - _loc2_ * 60 * 60 - _loc4_ * 60;
         var _loc5_:String = "";
         if(_loc2_ > 0)
         {
            _loc5_ = _loc2_ + ":";
         }
         _loc5_ = _loc4_ < 10 ? _loc5_ + "0" + _loc4_ : _loc5_ + _loc4_;
         _loc5_ = _loc5_ + ":";
         return _loc3_ < 10 ? _loc5_ + "0" + _loc3_ : _loc5_ + _loc3_;
      }
      
      private function activeThumbListEventProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var _loc3_:Point = new Point(WindowMouseEvent(param1).localX,WindowMouseEvent(param1).localY);
            var _loc5_:int = var_1413.resolveIndexFromImageLocation(null);
            var _loc4_:Effect = var_36.getItemInIndex(0,1);
            if(_loc4_ != null)
            {
               var_36.toggleEffectSelected(null.type);
            }
         }
      }
      
      private function inactiveThumbListEventProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var _loc3_:Point = new Point(WindowMouseEvent(param1).localX,WindowMouseEvent(param1).localY);
            var _loc5_:int = var_1445.resolveIndexFromImageLocation(null);
            var _loc4_:Effect = var_36.getItemInIndex(0,0);
            if(_loc4_ != null)
            {
               var_36.toggleEffectSelected(null.type);
            }
         }
      }
      
      private function windowEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:Effect = null;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "activateEffect_button")
            {
               _loc3_ = var_36.getSelectedEffect(0);
               if(_loc3_ != null)
               {
                  var_36.requestEffectActivated(_loc3_.type);
               }
            }
         }
      }
   }
}

