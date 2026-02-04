package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
   import com.sulake.habbo.catalog.targetedoffers.util.class_3689;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class OfferView implements class_13
   {
      
      protected var _window:class_1812;
      
      protected var var_55:OfferController;
      
      protected var _offer:TargetedOffer;
      
      protected var var_251:Timer;
      
      protected var _disposed:Boolean;
      
      protected var var_929:String;
      
      public function OfferView(param1:OfferController, param2:TargetedOffer)
      {
         super();
         var_55 = param1;
         _offer = param2;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_251 != null)
         {
            var_251.stop();
            var_251 = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      protected function startUpdateTimer() : void
      {
         var_251 = new Timer(1000);
         var_251.addEventListener("timer",onUpdateTimer);
         var_251.start();
         updateRemainingTime();
      }
      
      protected function onUpdateTimer(param1:TimerEvent) : void
      {
         updateRemainingTime();
      }
      
      protected function updateRemainingTime() : void
      {
         setTimeLeft(class_3689.getStringFromSeconds(var_55.catalog.localization,_offer.getSecondsRemaining()));
         if(_offer.getSecondsRemaining() == 0)
         {
            var_55.destroyView();
         }
      }
      
      protected function setTimeLeft(param1:String) : void
      {
         var _loc2_:ITextWindow = ITextWindow(_window.findChildByName("txt_time_left"));
         if(!_loc2_)
         {
            return;
         }
         _loc2_.text = var_929 != "" ? var_929.replace("%timeleft%",param1) : param1;
      }
      
      protected function getLocalization(param1:String, param2:String = null) : String
      {
         var _loc3_:String = var_55.catalog.localization.getLocalization(param1,param2 || param1);
         if(!_loc3_)
         {
            return null;
         }
         if(_offer)
         {
            _loc3_ = _loc3_.replace("%itemsleft%",_offer.purchaseLimit);
         }
         return _loc3_;
      }
   }
}

