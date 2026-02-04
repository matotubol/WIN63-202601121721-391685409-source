package com.sulake.habbo.catalog.collectibles.tabs
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.CollectiblesView;
   import com.sulake.habbo.catalog.collectibles.renderer.RewardCollectibleItemRenderer;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_3850;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_4046;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_4085;
   import com.sulake.habbo.localization.class_27;
   import flash.events.TimerEvent;
   import flash.globalization.DateTimeFormatter;
   import flash.utils.Timer;
   import package_36.class_2533;
   import package_36.class_3371;
   import package_70.class_2953;
   import package_70.class_3602;
   
   public class RewardClaimsTab implements class_31
   {
      
      private var _disposed:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_965:CollectiblesView;
      
      private var var_119:class_1812;
      
      private var var_196:CollectiblesController;
      
      private var var_966:IItemListWindow;
      
      private var _listItems:Vector.<RewardCollectibleItemRenderer>;
      
      private var var_2429:class_1741;
      
      private var var_2437:DateTimeFormatter;
      
      private var var_1049:Boolean;
      
      private var var_3150:Boolean;
      
      private var var_2425:Array = [];
      
      private var var_1968:Timer;
      
      private var _isRequestInProgress:Boolean = false;
      
      private var _loadingIcon:IStaticBitmapWrapperWindow;
      
      public function RewardClaimsTab(param1:CollectiblesView, param2:CollectiblesController)
      {
         super();
         var_965 = param1;
         var_196 = param2;
         var_2437 = new DateTimeFormatter("i-default");
         var_2437.setDateTimePattern("dd/MM/yyyy");
         var_1968 = new Timer(600);
         var_1968.addEventListener("timer",processNextRequest);
         var_119 = var_965.window.findChildByName("rewardsContainer") as class_1812;
         _loadingIcon = IStaticBitmapWrapperWindow(var_119.findChildByName("loading_icon"));
         var_966 = IItemListWindow(var_119.findChildByName("itemlist"));
         var_2429 = var_966.removeListItem(var_966.getListItemByName("item_template"));
         _listItems = new Vector.<RewardCollectibleItemRenderer>();
         setReady(false);
         addMessageEvents();
         updateClaimButtonState();
         param2.registerUpdateReceiver(this,1);
         claimButton.addEventListener("WME_CLICK",onClaimClicked);
      }
      
      private function addMessageEvents() : void
      {
         if(!var_196)
         {
            return;
         }
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new class_2533(onNftClaimsMessage));
         _messageEvents.push(new class_3371(onNftClaimResultMessage));
         for each(var _loc1_ in _messageEvents)
         {
            var_196.addMessageEvent(_loc1_);
         }
      }
      
      private function requestRewardClaims(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            requestClaimsForWallet(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function onWalletsAddressesUpdated(param1:Array) : void
      {
         requestRewardClaims(param1);
      }
      
      private function requestClaimsForWallet(param1:String) : void
      {
         var_2425.push(param1);
         if(!var_1968.running)
         {
            var_1968.start();
         }
      }
      
      private function processNextRequest(param1:TimerEvent) : void
      {
         if(_isRequestInProgress || var_2425.length == 0)
         {
            return;
         }
         var _loc2_:String = var_2425.shift();
         var_196.send(new class_3602(_loc2_));
         _isRequestInProgress = true;
      }
      
      private function updateClaimButtonState() : void
      {
         var _loc1_:Boolean = var_966 != null && var_966.numListItems > 0;
         var _loc2_:Boolean = !var_3150 && !_isRequestInProgress;
         if(_loc1_ && _loc2_)
         {
            claimButton.enable();
         }
         else
         {
            claimButton.disable();
         }
      }
      
      private function onClaimClicked(param1:WindowMouseEvent) : void
      {
         claimButton.disable();
         var_3150 = true;
         var_196.send(new class_2953());
         setReady(false);
      }
      
      private function onNftClaimsMessage(param1:class_2533) : void
      {
         var _loc3_:class_4046 = param1.getParser();
         for each(var _loc2_ in _loc3_.nftClaims)
         {
            if(_loc2_.claimedAmount < _loc2_.claimLimit)
            {
               createRewardItem(_loc2_);
            }
         }
         _isRequestInProgress = false;
         if(var_2425.length == 0)
         {
            var_1968.stop();
            setReady(true);
            updateClaimButtonState();
         }
      }
      
      private function onNftClaimResultMessage(param1:class_3371) : void
      {
         var _loc2_:class_3850 = param1.getParser();
         var_196.notifications.addItem(_loc2_.success ? localization.getLocalization("collectibles.claiming.success") : localization.getLocalizationWithParams("collectibles.claiming.failed","","id",_loc2_.resultCode),"info","icon_curator_stamp_large_png");
         if(_loc2_.success)
         {
            clearItems();
         }
         var_3150 = false;
         updateClaimButtonState();
         setReady(true);
      }
      
      private function createRewardItem(param1:class_4085) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:class_1812 = var_2429.clone() as class_1812;
         var _loc2_:RewardCollectibleItemRenderer = new RewardCollectibleItemRenderer(var_196,param1,_loc3_,this);
         _listItems.push(_loc2_);
         var_966.addListItem(_loc3_);
         _loc2_.updateVisuals();
         _loc2_.updateExpiresText(var_2437.format(new Date(param1.validTo)));
      }
      
      private function setReady(param1:Boolean) : void
      {
         var _loc2_:Boolean = var_966 != null && var_966.numListItems > 0;
         loadedContainer.visible = param1 && _loc2_;
         noContentContainer.visible = param1 && !_loc2_;
         loadingContainer.visible = !param1;
         var_1049 = param1;
      }
      
      private function get isReady() : Boolean
      {
         return var_1049;
      }
      
      private function get localization() : class_27
      {
         return var_196.localizationManager;
      }
      
      private function removeMessageEvents() : void
      {
         if(!var_196 || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            var_196.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      private function clearItems() : void
      {
         if(_listItems)
         {
            for each(var _loc1_ in _listItems)
            {
               _loc1_.dispose();
            }
            _listItems.length = 0;
         }
         if(var_966)
         {
            var_966.destroyListItems();
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         clearItems();
         var_1968.removeEventListener("timer",processNextRequest);
         removeMessageEvents();
         var_196.removeUpdateReceiver(this);
         super.dispose();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         if(!isReady)
         {
            _loc2_ = CollectionsTab.var_2370 * (param1 / 1000);
            _loadingIcon.rotation += _loc2_;
            _loadingIcon.rotation %= 360;
            _loadingIcon.invalidate();
         }
      }
      
      private function get loadingContainer() : class_1812
      {
         return var_119.findChildByName("loading_contents") as class_1812;
      }
      
      private function get loadedContainer() : class_1812
      {
         return var_119.findChildByName("loaded_content") as class_1812;
      }
      
      private function get noContentContainer() : class_1812
      {
         return var_119.findChildByName("no_content_container") as class_1812;
      }
      
      private function get claimButton() : class_1775
      {
         return var_119.findChildByName("claim_button") as class_1775;
      }
   }
}

