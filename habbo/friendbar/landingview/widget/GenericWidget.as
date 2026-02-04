package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.habbo.friendbar.landingview.*;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISlotAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.class_4080;
   import com.sulake.habbo.friendbar.landingview.interfaces.class_4081;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.ILayoutNameProvider;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.class_4112;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.class_4118;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.friendbar.landingview.widget.elements.TitleElementHandler;
   import com.sulake.habbo.friendbar.landingview.widget.elements.class_4115;
   
   public class GenericWidget implements ILandingViewWidget, ISlotAwareWidget, ISettingsAwareWidget, class_4080, class_4081
   {
      
      private var _landingView:HabboLandingView;
      
      private var _container:class_1812;
      
      private var var_2508:int;
      
      private var var_3163:String;
      
      private var var_997:class_55;
      
      public function GenericWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
         var_997 = new class_55();
      }
      
      public static function configureLayout(param1:HabboLandingView, param2:int, param3:String, param4:class_1812) : void
      {
         var _loc9_:Array = null;
         var _loc12_:String = null;
         var _loc11_:String = null;
         var _loc5_:String = getConf(param1,param2,param3,"layout");
         var _loc10_:Array = _loc5_.split(";");
         var _loc8_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(param4.findChildByName("bitmap"));
         var _loc6_:class_1741 = param4.findChildByName("content_container");
         _loc6_.x = isWideSlot(param2) ? 230 : 0;
         param4.width = isWideSlot(param2) ? param1.dynamicLayoutLeftPaneWidth : param1.dynamicLayoutRightPaneWidth;
         for each(var _loc7_ in _loc10_)
         {
            _loc9_ = _loc7_.split(",");
            _loc12_ = _loc9_[0];
            _loc11_ = _loc9_[1];
            switch(_loc12_)
            {
               case "bitmap.uri":
                  _loc8_.assetUri = _loc11_;
                  break;
               case "bitmap.width":
                  _loc8_.width = parseInt(_loc11_);
                  break;
               case "bitmap.height":
                  _loc8_.height = parseInt(_loc11_);
                  break;
               case "bitmap.x":
                  _loc8_.x = parseInt(_loc11_);
                  break;
               case "bitmap.y":
                  _loc8_.y = parseInt(_loc11_);
                  break;
               case "content.x":
                  _loc6_.x = parseInt(_loc11_);
                  break;
               case "content.y":
                  _loc6_.y = parseInt(_loc11_);
                  break;
               case "content.width":
                  _loc6_.width = parseInt(_loc11_);
                  break;
               case "container.height":
                  param4.height = Math.max(parseInt(_loc11_),param4.height);
            }
         }
      }
      
      private static function getConf(param1:HabboLandingView, param2:int, param3:String, param4:String) : String
      {
         var _loc5_:String = param3 != null ? "landing.view." + param3 + "." + param4 : "landing.view.dynamic.slot." + param2 + "." + param4;
         return param1.getProperty(_loc5_);
      }
      
      private static function isWideSlot(param1:int) : Boolean
      {
         return param1 != 3 && param1 != 5;
      }
      
      public function set slot(param1:int) : void
      {
         var_2508 = param1;
      }
      
      public function get configurationCode() : String
      {
         return var_3163;
      }
      
      public function set configurationCode(param1:String) : void
      {
         var_3163 = param1;
      }
      
      public function get container() : class_1741
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
         for each(var _loc1_ in var_997)
         {
            if(_loc1_ is class_13)
            {
               class_13(_loc1_).dispose();
            }
         }
         var_997 = null;
      }
      
      public function initialize() : void
      {
         _container = class_1812(_landingView.getXmlWindow("generic_widget"));
         configureContentColumn();
         configureLayout(_landingView,var_2508,var_3163,_container);
      }
      
      public function getElementByName(param1:String) : IElementHandler
      {
         return var_997.getValue(param1) as IElementHandler;
      }
      
      private function configureContentColumn() : void
      {
         var _loc6_:Array = null;
         var _loc8_:String = null;
         var _loc1_:IElementHandler = null;
         var _loc9_:String = null;
         var _loc5_:class_1741 = null;
         var _loc2_:String = getConf(_landingView,var_2508,var_3163,"conf");
         var _loc7_:Array = _loc2_.split(";");
         if(_loc2_ == null || _loc2_ == "")
         {
            return;
         }
         var _loc4_:IItemListWindow = IItemListWindow(_container.findChildByName("content_container"));
         var _loc13_:int = 0;
         var _loc12_:Array = _loc7_;
         while(true)
         {
            for each(var _loc3_ in _loc12_)
            {
               _loc6_ = _loc3_.split(",");
               _loc8_ = _loc6_[0];
               _loc1_ = class_4115.createHandler(_loc8_);
               _loc9_ = _loc1_ is ILayoutNameProvider ? ILayoutNameProvider(_loc1_).layoutName : "element_" + _loc8_;
               try
               {
                  _loc5_ = _landingView.getXmlWindow(_loc9_);
               }
               catch(e:Error)
               {
                  break;
               }
               if(_loc5_ == null)
               {
                  return;
               }
               if(_loc1_ != null)
               {
                  _loc1_.initialize(_landingView,_loc5_,_loc6_,this);
                  var_997.add(_loc8_,_loc1_);
               }
               if(_loc1_ is class_4118 && Boolean(class_4118(_loc1_).isFloating(isWideSlot(var_2508))))
               {
                  if(_loc1_ is TitleElementHandler)
                  {
                     _loc5_.width = isWideSlot(var_2508) ? _landingView.dynamicLayoutLeftPaneWidth : _landingView.dynamicLayoutRightPaneWidth;
                  }
                  _container.addChild(_loc5_);
               }
               else
               {
                  _loc4_.addListItem(_loc5_);
               }
            }
            return;
         }
      }
      
      public function refresh() : void
      {
         for each(var _loc1_ in var_997)
         {
            _loc1_.refresh();
         }
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
      
      public function disable() : void
      {
         for each(var _loc1_ in var_997)
         {
            if(_loc1_ is class_4112)
            {
               class_4112(_loc1_).disable();
            }
         }
      }
   }
}

