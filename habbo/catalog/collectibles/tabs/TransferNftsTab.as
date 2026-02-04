package com.sulake.habbo.catalog.collectibles.tabs
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.CollectiblesView;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_3745;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_3816;
   import com.sulake.habbo.localization.class_27;
   import package_36.class_2661;
   import package_36.class_3343;
   import package_70.class_2425;
   import package_70.class_2926;
   
   public class TransferNftsTab implements class_31
   {
      
      private var _disposed:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_965:CollectiblesView;
      
      private var var_119:class_1812;
      
      private var var_196:CollectiblesController;
      
      private var var_3156:Boolean;
      
      private var var_2812:Boolean;
      
      private var var_2211:int;
      
      private var _isTransferring:Boolean;
      
      private var var_2700:Array;
      
      private var _loadingIcon:IStaticBitmapWrapperWindow;
      
      public function TransferNftsTab(param1:CollectiblesView, param2:CollectiblesController)
      {
         super();
         var_965 = param1;
         var_196 = param2;
         var_119 = var_965.window.findChildByName("transferContainer") as class_1812;
         _loadingIcon = IStaticBitmapWrapperWindow(var_119.findChildByName("loading_icon"));
         addMessageEvents();
         initializeData();
         updateReadyState();
         updateTransferButtonState();
         param2.registerUpdateReceiver(this,1);
         transferButton.addEventListener("WME_CLICK",onTransferClicked);
         transferWalletSelection.addEventListener("WE_SELECTED",onSelectWallet);
      }
      
      private function onSelectWallet(param1:class_1758) : void
      {
         var _loc3_:int = transferWalletSelection.selection;
         if(_loc3_ >= 0)
         {
            var _loc2_:String = transferWalletSelection.enumerateSelection()[_loc3_];
            if(null.length > 32)
            {
               transferWalletSelection.caption = null.substring(0,32) + "...";
            }
         }
         updateReadyState();
      }
      
      private function addMessageEvents() : void
      {
         if(!var_196)
         {
            return;
         }
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new class_2661(onNftTransferFeeMessage));
         _messageEvents.push(new class_3343(onNftTransferResultMessage));
         for each(var _loc1_ in _messageEvents)
         {
            var_196.addMessageEvent(_loc1_);
         }
      }
      
      private function onNftTransferFeeMessage(param1:class_2661) : void
      {
         var_3156 = false;
         var _loc2_:class_3745 = param1.getParser();
         var_2211 = _loc2_.transferFee;
         silverFeeText.text = String(var_2211);
         silverFeeText.visible = var_2211 > 0;
         silverIcon.visible = var_2211 > 0;
         updateReadyState();
         updateTransferButtonState();
      }
      
      private function updateReadyState() : void
      {
         loadedContainer.visible = isReady;
         loadingContainer.visible = !isReady;
      }
      
      private function updateTransferButtonState() : void
      {
         var _loc1_:* = var_2211 <= var_196.catalog.getPurse().silverBalance;
         var _loc2_:Boolean = var_965.stardustWallet != null && var_965.stardustWallet != "";
         var _loc4_:* = !_isTransferring;
         var _loc3_:* = selectedWallet != null;
         if(_loc1_ && _loc2_ && _loc4_ && _loc3_)
         {
            transferButton.enable();
         }
         else
         {
            transferButton.disable();
         }
      }
      
      public function onSilverBalanceUpdated() : void
      {
         updateTransferButtonState();
      }
      
      private function onTransferClicked(param1:WindowMouseEvent) : void
      {
         transferButton.disable();
         var _loc2_:class_2001 = var_196.windowManager.confirm("${collectibles.transfer}","${collectibles.transfer.confirm}",0,onTransferConfirm);
         _loc2_.titleBarColor = 2763306;
      }
      
      private function onTransferConfirm(param1:class_2001, param2:class_1758) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            _isTransferring = true;
            var_196.send(new class_2926(selectedWallet));
         }
         updateTransferButtonState();
      }
      
      private function onNftTransferResultMessage(param1:class_3343) : void
      {
         var _loc2_:class_3816 = param1.getParser();
         var_196.notifications.addItem(_loc2_.success ? localization.getLocalization("collectibles.transfer.success") : localization.getLocalizationWithParams("collectibles.transfer.error","","id",_loc2_.resultCode),"info","icon_curator_stamp_large_png");
         _isTransferring = false;
         updateTransferButtonState();
      }
      
      public function onWalletsAddressesUpdated(param1:Array) : void
      {
         initializeTransferWallets(param1);
      }
      
      private function initializeTransferWallets(param1:Array) : void
      {
         transferWalletSelection.populate(param1);
         var_2700 = param1;
         if(param1.length == 0)
         {
            transferWalletSelection.color = 13421772;
            transferWalletSelection.disable();
         }
         else
         {
            transferWalletSelection.color = 16777215;
            transferWalletSelection.enable();
            transferWalletSelection.selection = 0;
         }
         var_2812 = false;
         updateReadyState();
         updateTransferButtonState();
      }
      
      private function get selectedWallet() : String
      {
         if(var_2700 == null)
         {
            return null;
         }
         var _loc1_:int = transferWalletSelection.selection;
         if(_loc1_ < 0 || _loc1_ >= var_2700.length)
         {
            return null;
         }
         return var_2700[_loc1_];
      }
      
      private function initializeData() : void
      {
         var_3156 = true;
         var_196.send(new class_2425());
         var _loc1_:Array = var_965.walletAddresses;
         if(_loc1_)
         {
            initializeTransferWallets(_loc1_);
         }
         var_2812 = _loc1_ == null;
      }
      
      private function get isReady() : Boolean
      {
         return !var_2812 && !var_3156;
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
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
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
      
      private function get silverFeeText() : ITextWindow
      {
         return var_119.findChildByName("transfer_fee_text") as ITextWindow;
      }
      
      private function get transferButton() : class_1775
      {
         return var_119.findChildByName("transfer_button") as class_1775;
      }
      
      private function get transferWalletSelection() : class_2261
      {
         return var_119.findChildByName("transfer_wallet_selection") as class_2261;
      }
      
      private function get silverIcon() : IStaticBitmapWrapperWindow
      {
         return var_119.findChildByName("transfer_fee_icon") as IStaticBitmapWrapperWindow;
      }
   }
}

