package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   
   public class RoomHopperNetworkWidget implements ILandingViewWidget, ISettingsAwareWidget
   {
      
      private var _landingView:HabboLandingView;
      
      private var _container:class_1812;
      
      private var _disposed:Boolean = false;
      
      private var var_5141:int;
      
      private var var_3357:Array = [];
      
      public function RoomHopperNetworkWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
         var_3357.push("title");
         var_3357.push("header");
         var_3357.push("info");
      }
      
      protected static function get xmlAssetName() : String
      {
         return "room_hopper_network";
      }
      
      public function initialize() : void
      {
         _container = class_1812(_landingView.getXmlWindow(xmlAssetName));
         var_5141 = _landingView.getInteger("landing.view.roomhopper.network.id",0);
         var _loc1_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_container.findChildByName("bitmap"));
         _loc1_.assetUri = _landingView.getProperty("landing.view.roomhopper.image.uri");
         _container.findChildByName("button").procedure = onRoomForwardButton;
      }
      
      public function refresh() : void
      {
      }
      
      public function get container() : class_1741
      {
         return _container;
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(_container)
            {
               _container.dispose();
               _container = null;
            }
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
      
      private function onRoomForwardButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.navigator.goToRoomNetwork(var_5141,false);
         }
      }
   }
}

