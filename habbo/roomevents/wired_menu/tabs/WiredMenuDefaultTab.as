package com.sulake.habbo.roomevents.wired_menu.tabs
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   
   public class WiredMenuDefaultTab implements class_2710
   {
      
      private var var_1134:Boolean = false;
      
      private var var_55:WiredMenuController;
      
      private var _container:class_1812;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_1037:Boolean;
      
      private var var_1000:Boolean;
      
      private var var_1757:Boolean;
      
      public function WiredMenuDefaultTab(param1:WiredMenuController, param2:class_1812)
      {
         super();
         var_55 = param1;
         _container = param2;
         _messageEvents = new Vector.<IMessageEvent>(0);
         var _loc3_:class_31 = this as class_31;
         if(_loc3_ != null)
         {
            param1.context.registerUpdateReceiver(_loc3_,1);
         }
      }
      
      public function setTabActive() : void
      {
         var_1037 = true;
      }
      
      public function setTabInactive() : void
      {
         var_1037 = false;
      }
      
      public function startViewing() : void
      {
         var_1000 = true;
      }
      
      public function stopViewing() : void
      {
         var_1000 = false;
         if(var_1757)
         {
            var_55.view.loadingContainer.visible = false;
         }
      }
      
      protected function updateLoadingState() : void
      {
         var _loc1_:Boolean = isDataReady();
         if(var_1757 && _loc1_)
         {
            initializeInterface();
         }
         var_1757 = !_loc1_;
         var _loc2_:class_1812 = var_55.view.loadingContainer;
         if(var_1000 && _loc2_.visible != var_1757)
         {
            _loc2_.visible = var_1757;
            controller.view.window.caption = controller.localizationManager.getLocalization(var_1757 ? "wiredmenu.title.loading" : "wiredmenu.title");
         }
      }
      
      protected function isDataReady() : Boolean
      {
         return true;
      }
      
      protected function initializeInterface() : void
      {
      }
      
      public function get controller() : WiredMenuController
      {
         return var_55;
      }
      
      protected function get localization() : class_27
      {
         return var_55.localizationManager;
      }
      
      protected function loc(param1:String) : String
      {
         return localization.getLocalization(param1,"");
      }
      
      public function get container() : class_1812
      {
         return _container;
      }
      
      public function get isActive() : Boolean
      {
         return var_1037;
      }
      
      public function get isViewing() : Boolean
      {
         return var_1000;
      }
      
      public function get isLoading() : Boolean
      {
         return var_1757;
      }
      
      protected function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(param1);
         var_55.addMessageEvent(param1);
      }
      
      private function removeMessageEvents() : void
      {
         for each(var _loc1_ in _messageEvents)
         {
            var_55.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      public function dispose() : void
      {
         if(var_1134)
         {
            return;
         }
         removeMessageEvents();
         var _loc1_:class_31 = this as class_31;
         if(_loc1_ != null)
         {
            controller.context.removeUpdateReceiver(_loc1_);
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function permissionsUpdated() : void
      {
      }
   }
}

