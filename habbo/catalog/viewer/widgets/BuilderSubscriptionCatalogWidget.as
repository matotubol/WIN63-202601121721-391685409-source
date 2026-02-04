package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBuilderSubscriptionUpdatedEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   
   public class BuilderSubscriptionCatalogWidget extends CatalogWidget implements class_2612, class_13
   {
      
      private var _catalog:HabboCatalog;
      
      private var var_2969:String;
      
      public function BuilderSubscriptionCatalogWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var_2969 = _catalog.getProperty("builders_club.buy_membership_page");
         updateSubscriptionInfo();
         _window.procedure = windowProcedure;
         events.addEventListener("CWE_BUILDER_SUBSCRIPTION_UPDATED",onBuilderSubscriptionUpdated);
         return true;
      }
      
      private function updateSubscriptionInfo() : void
      {
         var _loc4_:Number = _catalog.builderSecondsLeft;
         var _loc2_:class_1741 = _window.findChildByName("subscribe_button");
         var _loc3_:class_1741 = _window.findChildByName("subscribe_button_sms");
         var _loc1_:class_1741 = _window.findChildByName("subscribe_button_big");
         var _loc5_:class_1741 = _window.findChildByName("try_button");
         if(_loc5_ == null || _loc2_ == null || _loc1_ == null)
         {
            return;
         }
         if(_loc4_ > 0 || _catalog.getCatalogNavigator("BUILDERS_CLUB").getOptionalNodeByName(_catalog.getProperty("builders_club.try_page")) == null)
         {
            _loc1_.visible = true;
            _loc2_.visible = false;
            _loc5_.visible = false;
            _loc3_.visible = false;
         }
         else
         {
            _loc1_.visible = false;
            _loc2_.visible = false;
            _loc5_.visible = true;
            _loc3_.visible = false;
         }
         if(var_2969 != null && var_2969 != "")
         {
            _loc3_.visible = true;
            if(!_loc5_.visible)
            {
               _loc3_.x = _loc5_.x;
               _loc3_.y = _loc5_.y;
            }
            if(_loc1_.visible)
            {
               _loc1_.visible = false;
               _loc2_.visible = false;
            }
         }
      }
      
      private function onBuilderSubscriptionUpdated(param1:CatalogWidgetBuilderSubscriptionUpdatedEvent) : void
      {
         updateSubscriptionInfo();
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "subscribe_button_big":
            case "subscribe_button":
               HabboWebTools.openWebPageAndMinimizeClient(_catalog.getProperty("web.shop.subscription.relativeUrl"));
               break;
            case "subscribe_button_sms":
               HabboWebTools.openWebPageAndMinimizeClient(var_2969);
               break;
            case "try_button":
               _catalog.openCatalogPage(_catalog.getProperty("builders_club.try_page"),"BUILDERS_CLUB");
         }
      }
   }
}

