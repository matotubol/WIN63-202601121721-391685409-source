package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.friendbar.landingview.*;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISlotAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.class_4080;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.LandingViewWidgetType;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainer;
   import flash.utils.Dictionary;
   import package_140.class_2933;
   import package_81.class_3513;
   
   public class WidgetContainerWidget implements ILandingViewWidget, ISlotAwareWidget
   {
      
      private var _landingView:HabboLandingView;
      
      private var _container:class_1812;
      
      private var var_35:Dictionary = new Dictionary();
      
      private var var_1318:CommonWidgetSettings;
      
      private var var_2508:int;
      
      private var var_3488:String;
      
      private var var_1262:WidgetContainer;
      
      public function WidgetContainerWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public static function hideChildren(param1:class_1812) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            param1.getChildAt(_loc2_).visible = false;
            _loc2_++;
         }
      }
      
      public function set slot(param1:int) : void
      {
         var_2508 = param1;
      }
      
      public function get container() : class_1741
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
      }
      
      public function initialize() : void
      {
         _container = class_1812(_landingView.getXmlWindow("widget_container_widget"));
         var_1318 = new CommonWidgetSettings(_landingView);
         _landingView.communicationManager.addHabboConnectionMessageEvent(new class_2933(onTimingCode));
         var_3488 = _landingView.getProperty("landing.view.dynamic.slot." + var_2508 + ".conf");
      }
      
      public function refresh() : void
      {
         _landingView.send(new class_3513(var_3488));
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function refreshContent() : void
      {
         hideChildren(_container);
         if(var_1262 != null)
         {
            var_1262.refresh(_container);
            var_1262.container.visible = true;
            _container.height = var_1262.container.height;
            _container.width = var_1262.container.width;
         }
      }
      
      private function createWidgetContainer(param1:String) : WidgetContainer
      {
         var _loc3_:String = _landingView.getProperty("landing.view." + param1 + ".widget");
         var _loc2_:ILandingViewWidget = LandingViewWidgetType.getWidgetForType(_loc3_,_landingView);
         if(_loc2_ == null)
         {
            return null;
         }
         if(_loc2_ is ISlotAwareWidget)
         {
            ISlotAwareWidget(_loc2_).slot = var_2508;
         }
         if(_loc2_ is class_4080)
         {
            class_4080(_loc2_).configurationCode = param1;
         }
         var _loc4_:WidgetContainer = new WidgetContainer(_loc2_,null,var_1318,_container);
         var_35[param1] = _loc4_;
         return _loc4_;
      }
      
      private function onTimingCode(param1:class_2933) : void
      {
         if(param1.getParser().schedulingStr == var_3488 && !disposed)
         {
            switchCurrentWidget(param1.getParser().code);
            refreshContent();
         }
      }
      
      private function switchCurrentWidget(param1:String) : void
      {
         if(param1 == "")
         {
            var_1262 = null;
            return;
         }
         var _loc2_:WidgetContainer = var_35[param1];
         if(_loc2_ == null)
         {
            _loc2_ = createWidgetContainer(param1);
         }
         var_1262 = _loc2_;
      }
   }
}

