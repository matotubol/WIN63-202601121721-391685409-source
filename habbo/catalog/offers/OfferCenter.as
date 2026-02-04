package com.sulake.habbo.catalog.offers
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.window.class_38;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import package_26.class_3029;
   import package_46.class_2376;
   
   public class OfferCenter implements IOfferCenter, class_13
   {
      
      private static const PROVIDER_POLLING_FREQUENCY:int = 1800000;
      
      private var _disposed:Boolean;
      
      private var _windowManager:class_38;
      
      private var _assets:class_40;
      
      private var _catalog:IHabboCatalog;
      
      private var _offerExtension:IOfferExtension;
      
      private var _window:class_1812;
      
      private var var_1626:IOfferProvider;
      
      private var _providers:Vector.<IOfferProvider>;
      
      private var var_2584:Vector.<OfferReward>;
      
      private var var_2429:class_1741;
      
      private var var_1176:Timer;
      
      private var _offerRewardDeliveredMessageEvent:class_3029;
      
      public function OfferCenter(param1:class_38, param2:class_40, param3:IHabboCatalog)
      {
         super();
         _windowManager = param1;
         _assets = param2;
         _catalog = param3;
         _offerRewardDeliveredMessageEvent = new class_3029(onOfferRewardDelivered);
         _catalog.connection.addMessageEvent(_offerRewardDeliveredMessageEvent);
         _providers = new Vector.<IOfferProvider>(0);
         _providers.push(new SupersonicProvider(this));
         _providers.push(new SponsorPayProvider(this));
         var_2584 = new Vector.<OfferReward>(0);
         var_1176 = new Timer(1800000);
         var_1176.addEventListener("timer",onPollTimer);
         var_1176.start();
         onPollTimer(null);
      }
      
      private function onPollTimer(param1:TimerEvent) : void
      {
         if(_providers == null)
         {
            return;
         }
         for each(var _loc2_ in _providers)
         {
            if(_loc2_.enabled)
            {
               _loc2_.load();
            }
         }
      }
      
      private function getNextProvider() : IOfferProvider
      {
         if(_providers == null)
         {
            return null;
         }
         for each(var _loc1_ in _providers)
         {
            if(_loc1_.enabled && _loc1_.videoAvailable)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      private function onOfferRewardDelivered(param1:class_3029) : void
      {
         var _loc2_:class_2376 = param1.getParser();
         addReward(_loc2_.name,_loc2_.contentType,_loc2_.classId);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(_providers != null)
         {
            for each(var _loc1_ in _providers)
            {
               _loc1_.dispose();
            }
            _providers = null;
         }
         if(var_1176 != null)
         {
            var_1176.stop();
            var_1176 = null;
         }
         _catalog.connection.removeMessageEvent(_offerRewardDeliveredMessageEvent);
         _offerRewardDeliveredMessageEvent = null;
         var_2584 = null;
         _offerExtension = null;
         _windowManager = null;
         _catalog = null;
         _assets = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set offerExtension(param1:IOfferExtension) : void
      {
         _offerExtension = param1;
      }
      
      public function showRewards() : void
      {
         hide();
         _window = _windowManager.buildFromXML(_assets.getAssetByName("offer_center_xml").content as XML) as class_1812;
         _window.procedure = windowProcedure;
         _window.center();
         var_2429 = IItemListWindow(_window.findChildByName("reward_list")).removeListItemAt(0);
         populateRewardList();
      }
      
      public function showVideo() : void
      {
         if(var_1626 != null)
         {
            var_1626.showVideo();
         }
      }
      
      public function get showingVideo() : Boolean
      {
         return var_1626 != null && var_1626.showingPopup;
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK" || !visible)
         {
            return;
         }
         var _loc3_:* = param2.name;
         if("header_button_close" === _loc3_)
         {
            hide();
         }
      }
      
      private function hide() : void
      {
         if(_window != null)
         {
            var_2429.dispose();
            var_2429 = null;
            _window.dispose();
            _window = null;
         }
      }
      
      private function addReward(param1:String, param2:String, param3:int) : void
      {
         var _loc4_:OfferReward = new OfferReward(param1,param2,param3);
         var_2584.unshift(_loc4_);
         if(visible)
         {
            IItemListWindow(_window.findChildByName("reward_list")).addListItemAt(createRewardItem(_loc4_),0);
         }
         else if(_offerExtension != null)
         {
            _offerExtension.indicateRewards();
         }
      }
      
      public function get configuration() : class_16
      {
         return _catalog as class_16;
      }
      
      public function updateVideoStatus() : void
      {
         if(_offerExtension != null)
         {
            var_1626 = getNextProvider();
            _offerExtension.indicateVideoAvailable(var_1626 != null && var_1626.videoAvailable);
         }
      }
      
      private function populateRewardList() : void
      {
         if(!visible)
         {
            return;
         }
         var _loc2_:IItemListWindow = _window.findChildByName("reward_list") as IItemListWindow;
         _loc2_.destroyListItems();
         for each(var _loc1_ in var_2584)
         {
            _loc2_.addListItem(createRewardItem(_loc1_));
         }
      }
      
      private function createRewardItem(param1:OfferReward) : class_1741
      {
         var _loc2_:class_1812 = var_2429.clone() as class_1812;
         _loc2_.findChildByName("reward_date").caption = new Date().toLocaleString();
         _loc2_.findChildByName("reward_name").caption = param1.name;
         _catalog.displayProductIcon(param1.contentType,param1.classId,class_2251(_loc2_.findChildByName("reward_icon")));
         return _loc2_;
      }
      
      private function get visible() : Boolean
      {
         return _window != null && !_window.disposed && Boolean(_window.visible);
      }
      
      public function showSuccess() : void
      {
      }
   }
}

