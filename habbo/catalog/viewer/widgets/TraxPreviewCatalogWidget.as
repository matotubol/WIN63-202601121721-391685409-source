package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.viewer.class_1857;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.class_544;
   
   public class TraxPreviewCatalogWidget extends CatalogWidget implements class_2612
   {
      
      private var _soundManager:class_544;
      
      private var var_1040:class_1775;
      
      private var var_914:int = -1;
      
      public function TraxPreviewCatalogWidget(param1:class_1812, param2:class_544)
      {
         super(param1);
         var_1040 = _window.findChildByName("listen") as class_1775;
         class_21.log("Trax listener found button: " + var_1040);
         if(var_1040 != null)
         {
            var_1040.addEventListener("WME_CLICK",onClickPlay);
            var_1040.disable();
         }
         _soundManager = param2;
      }
      
      override public function dispose() : void
      {
         if(var_1040 != null)
         {
            var_1040.removeEventListener("WME_CLICK",onClickPlay);
         }
         if(_soundManager != null && _soundManager.musicController != null)
         {
            _soundManager.musicController.stop(3);
            _soundManager = null;
         }
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         if(page.offers.length == 0)
         {
            return false;
         }
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         return true;
      }
      
      override public function closed() : void
      {
         super.closed();
         if(_soundManager != null && _soundManager.musicController != null)
         {
            _soundManager.musicController.stop(3);
         }
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null || param1.offer == null)
         {
            return;
         }
         var _loc2_:class_1857 = param1.offer.product;
         if(_loc2_.extraParam.length > 0)
         {
            var_914 = parseInt(_loc2_.extraParam);
            var _loc3_:Boolean = true;
         }
         if(var_1040 != null)
         {
            var_1040.disable();
         }
      }
      
      private function onClickPlay(param1:WindowMouseEvent) : void
      {
         if(_soundManager != null && _soundManager.musicController != null)
         {
            forceNoFadeoutOnPlayingSong(0);
            forceNoFadeoutOnPlayingSong(3);
            _soundManager.musicController.playSong(var_914,3,15,40,0,2);
         }
      }
      
      private function forceNoFadeoutOnPlayingSong(param1:int) : void
      {
         var _loc3_:int = _soundManager.musicController.getSongIdPlayingAtPriority(param1);
         if(_loc3_ != -1)
         {
            var _loc2_:ISongInfo = _soundManager.musicController.getSongInfo(_loc3_);
            if(null.soundObject != null)
            {
               null.soundObject.fadeOutSeconds = 0;
            }
         }
      }
   }
}

