package com.sulake.habbo.ui.widget.furniture.mysterybox
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import package_180.class_3105;
   import package_52.class_2962;
   import package_52.class_3084;
   import package_52.class_3296;
   import package_55.class_2945;
   import package_63.class_3888;
   
   public class MysteryBoxOpenDialogView implements class_13, class_1829
   {
      
      private var _disposed:Boolean;
      
      private var var_16:FurnitureContextMenuWidget;
      
      private var var_393:IModalDialog;
      
      private var _window:class_1812;
      
      private var var_612:IRoomObject;
      
      private var var_2650:class_2962;
      
      private var var_2412:class_3084;
      
      private var var_2453:class_3296;
      
      private var var_1854:int = -1;
      
      public function MysteryBoxOpenDialogView(param1:FurnitureContextMenuWidget)
      {
         super();
         var_16 = param1;
         var_2650 = new class_2962(onShowMysteryBoxWait);
         var_2412 = new class_3084(onCancelMysteryBoxWait);
         var_2453 = new class_3296(onGotMysteryBoxPrize);
         connection.addMessageEvent(var_2650);
         connection.addMessageEvent(var_2412);
         connection.addMessageEvent(var_2453);
      }
      
      private function onShowMysteryBoxWait(param1:class_2962) : void
      {
         showWaitWindow();
      }
      
      private function onCancelMysteryBoxWait(param1:class_3084) : void
      {
         closeWindow();
      }
      
      private function onGotMysteryBoxPrize(param1:class_3296) : void
      {
         var _loc2_:class_3888 = param1.getParser();
         showRewardWindow(_loc2_.contentType,_loc2_.classId);
      }
      
      private function showWaitWindow() : void
      {
         closeWindow();
         var _loc1_:XML = var_16.assets.getAssetByName("mystery_box_open_dialog").content as XML;
         var_393 = var_16.handler.container.windowManager.buildModalDialogFromXML(_loc1_);
         _window = var_393.rootWindow as class_1812;
         _window.procedure = waitWindowProcedure;
         var _loc4_:Boolean = var_16.handler.container.isOwnerOfFurniture(var_612);
         var _loc5_:String = _loc4_ ? "mysterybox.dialog.owner." : "mysterybox.dialog.other.";
         _window.caption = "${" + _loc5_ + "title}";
         _window.findChildByName("subtitle_text").caption = "${" + _loc5_ + "subtitle}";
         _window.findChildByName("waiting_text").caption = "${" + _loc5_ + "waiting}";
         _window.findChildByName("cancel_button").caption = "${" + _loc5_ + "cancel}";
         IStaticBitmapWrapperWindow(_window.findChildByName("reward_base")).assetUri = _loc4_ ? "mysterybox_box_base" : "mysterybox_key_base";
         IStaticBitmapWrapperWindow(_window.findChildByName("reward_overlay")).assetUri = _loc4_ ? "mysterybox_box_overlay" : "mysterybox_key_overlay";
         IStaticBitmapWrapperWindow(_window.findChildByName("needed_base")).assetUri = _loc4_ ? "mysterybox_key_base" : "mysterybox_box_base";
         IStaticBitmapWrapperWindow(_window.findChildByName("needed_overlay")).assetUri = _loc4_ ? "mysterybox_key_overlay" : "mysterybox_box_overlay";
         var _loc6_:ISessionDataManager = var_16.handler.container.sessionDataManager;
         var _loc2_:String = _loc4_ ? _loc6_.mysteryBoxColor : _loc6_.mysteryKeyColor;
         if(_loc2_ == null || _loc2_ == "")
         {
            return;
         }
         var _loc3_:uint = uint(MysteryBoxToolbarExtension.KEY_COLORS[_loc2_.toLowerCase()]);
         _window.findChildByName("reward_base").color = _loc3_;
         _window.findChildByName("needed_base").color = _loc3_;
      }
      
      private function waitWindowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_button":
               closeWindow();
               connection.send(new class_3105(var_16.handler.container.getFurnitureOwnerId(var_612)));
         }
      }
      
      private function showRewardWindow(param1:String, param2:int) : void
      {
         closeWindow();
         var _loc3_:XML = var_16.assets.getAssetByName("mystery_box_reward").content as XML;
         var_393 = var_16.handler.container.windowManager.buildModalDialogFromXML(_loc3_);
         _window = var_393.rootWindow as class_1812;
         _window.procedure = rewardWindowProcedure;
         var_1854 = -1;
         var _loc4_:class_2198 = null;
         switch(param1)
         {
            case "s":
               _loc4_ = var_16.handler.container.roomEngine.getFurnitureImage(param2,new Vector3d(90,0,0),64,this,0);
               break;
            case "i":
               _loc4_ = var_16.handler.container.roomEngine.getWallItemImage(param2,new Vector3d(90,0,0),64,this,0);
               break;
            case "e":
               rewardBitmap = var_16.handler.container.catalog.getPixelEffectIcon(param2);
               break;
            case "h":
               rewardBitmap = var_16.handler.container.catalog.getSubscriptionProductIcon(param2);
               break;
            default:
               return;
         }
         if(_loc4_ != null)
         {
            if(_loc4_.data != null)
            {
               rewardBitmap = _loc4_.data;
            }
            var_1854 = _loc4_.id;
         }
      }
      
      private function set rewardBitmap(param1:BitmapData) : void
      {
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:class_2251 = _window.findChildByName("reward_image") as class_2251;
         var _loc2_:class_1741 = _window.findChildByName("bitmap_container");
         _loc3_.bitmap = param1;
         _loc2_.width = param1.width;
         _loc2_.height = param1.height;
         _loc2_.width++;
      }
      
      private function rewardWindowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param1.target.name)
         {
            case "header_button_close":
            case "close_button":
               closeWindow();
         }
      }
      
      private function closeWindow() : void
      {
         if(var_393 != null && !var_393.disposed)
         {
            _window = null;
            var_393.dispose();
            var_393 = null;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         closeWindow();
         connection.removeMessageEvent(var_2650);
         connection.removeMessageEvent(var_2412);
         connection.removeMessageEvent(var_2453);
         var_2650 = null;
         var_2412 = null;
         var_2453 = null;
         var_612 = null;
         var_16 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function startOpenFlow(param1:IRoomObject) : void
      {
         var_612 = param1;
         connection.send(new class_2945(param1.getId()));
      }
      
      private function get connection() : IConnection
      {
         return var_16.handler.container.connection;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(param1 == var_1854)
         {
            var_1854 = -1;
            rewardBitmap = param2;
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}

