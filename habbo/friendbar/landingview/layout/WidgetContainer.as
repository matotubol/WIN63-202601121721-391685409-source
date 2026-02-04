package com.sulake.habbo.friendbar.landingview.layout
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.IResizeAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.class_4081;
   
   public class WidgetContainer implements class_13
   {
      
      private var var_16:ILandingViewWidget;
      
      private var _placeholderName:String;
      
      private var var_3532:class_1812;
      
      private var var_704:Boolean;
      
      private var var_1318:CommonWidgetSettings;
      
      public function WidgetContainer(param1:ILandingViewWidget, param2:String, param3:CommonWidgetSettings, param4:class_1812 = null)
      {
         super();
         var_16 = param1;
         _placeholderName = param2;
         var_1318 = param3;
         var_3532 = param4;
      }
      
      public function dispose() : void
      {
         if(var_16)
         {
            var_16.dispose();
            var_16 = null;
         }
         if(var_1318)
         {
            var_1318 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_16 == null && var_1318 == null;
      }
      
      public function refresh(param1:class_1812) : void
      {
         var _loc2_:class_1812 = class_1812(param1.findChildByName("content_background"));
         if(!var_704)
         {
            var_704 = true;
            if(_placeholderName != null)
            {
               var _loc3_:class_1741 = _loc2_.getChildByName(_placeholderName);
               return;
            }
            if(!(var_3532 != null && var_16 != null))
            {
               return;
            }
            var_16.initialize();
            var_3532.addChild(var_16.container);
         }
         if(var_16.container != null)
         {
            if(var_16 is ISettingsAwareWidget && var_1318 != null)
            {
               ISettingsAwareWidget(var_16).settings = var_1318;
            }
            var_16.refresh();
         }
      }
      
      public function get container() : class_1741
      {
         return var_16.container;
      }
      
      public function windowResized() : void
      {
         if(var_16 != null && var_16.container != null && var_16 is IResizeAwareWidget)
         {
            IResizeAwareWidget(var_16).windowResized();
         }
      }
      
      public function disable() : void
      {
         if(var_16 != null && var_16.container != null && var_16 is class_4081)
         {
            class_4081(var_16).disable();
         }
      }
   }
}

