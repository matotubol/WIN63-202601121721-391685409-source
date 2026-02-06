package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.inventory.events.HabboInventoryFurniListParsedEvent;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.session.product.class_1949;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.RoomDesktop;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInvalidateEvent;
   import com.sulake.habbo.communication.messages.outgoing.crafting.CraftComposer;
   import com.sulake.habbo.communication.messages.outgoing.crafting.GetCraftableProductsComposer;
   import com.sulake.habbo.communication.messages.outgoing.crafting.CraftSecretComposer;
   import com.sulake.habbo.communication.messages.outgoing.crafting.GetCraftingRecipesAvailableComposer;
   import com.sulake.habbo.communication.messages.outgoing.crafting.GetCraftingRecipeComposer;
   import com.sulake.habbo.communication.messages.incoming.crafting.CraftingRecipesAvailableMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.crafting.CraftingRecipeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.crafting.CraftingResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.crafting.CraftableProductsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryComposer;
   import com.sulake.habbo.communication.messages.parser.crafting.class_2398;
   
   public class CraftingWidgetHandler implements IRoomWidgetHandler
   {
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer;
      
      private var var_16:CraftingWidget;
      
      private var var_1099:RoomDesktop;
      
      private var var_1701:IMessageEvent;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_1105:int;
      
      private var var_2658:Boolean;
      
      private var var_1789:Boolean;
      
      private var _craftingInProgress:Boolean;
      
      private var var_3252:class_1949;
      
      private var var_2539:String;
      
      public function CraftingWidgetHandler(param1:RoomDesktop)
      {
         super();
         var_1099 = param1;
      }
      
      public function dispose() : void
      {
         removeMessageEvents();
         var_16 = null;
         _container = null;
         var_1099 = null;
         var_3252 = null;
         var_2539 = null;
         _disposed = true;
      }
      
      private function addMessageEvents() : void
      {
         if(!_container || !_container.connection)
         {
            return;
         }
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new CraftableProductsMessageEvent(onCraftableProductsMessage));
         _messageEvents.push(new CraftingRecipeMessageEvent(onCraftingRecipeMessage));
         _messageEvents.push(new CraftingResultMessageEvent(onCraftingResultMessage));
         _messageEvents.push(new CraftingRecipesAvailableMessageEvent(onCraftingRecipesAvailableMessage));
         for each(var _loc1_ in _messageEvents)
         {
            _container.connection.addMessageEvent(_loc1_);
         }
      }
      
      private function removeMessageEvents() : void
      {
         if(!_container || !_container.connection || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            _container.connection.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         removeInventoryUpdateEvent();
         if(_container.inventory && _container.inventory.events)
         {
            _container.inventory.events.removeEventListener("HFLPE_FURNI_LIST_PARSED",onFurniListParsed);
         }
         _messageEvents = null;
      }
      
      public function initializeData() : void
      {
         if(var_2658)
         {
            return;
         }
         var_2658 = true;
         if(_container.inventory.checkCategoryInitilization("furni"))
         {
            getCraftableProducts();
         }
      }
      
      private function onFurniListParsed(param1:HabboInventoryFurniListParsedEvent) : void
      {
         if(var_2658 && param1.category == "furni")
         {
            getCraftableProducts();
         }
      }
      
      private function getCraftableProducts() : void
      {
         _container.connection.send(new GetCraftableProductsComposer(var_1105));
      }
      
      private function onCraftableProductsMessage(param1:CraftableProductsMessageEvent) : void
      {
         var_2658 = false;
         if(!var_16)
         {
            return;
         }
         if(!param1.getParser().hasData())
         {
            var_16.hide();
            return;
         }
         var_16.showWidget();
         var_16.showCraftingCategories(param1.getParser().recipeProductItems,param1.getParser().usableInventoryFurniClasses,_container.roomEngine,_container.sessionDataManager);
         var_1789 = false;
      }
      
      public function getCraftingRecipe(param1:String, param2:String) : void
      {
         var_3252 = _container.sessionDataManager.getProductData(param2);
         var_2539 = param1;
         _container.connection.send(new GetCraftingRecipeComposer(param1));
      }
      
      private function onCraftingRecipeMessage(param1:CraftingRecipeMessageEvent) : void
      {
         var_16.showCraftingRecipe(param1.getParser().ingredients);
      }
      
      public function getCraftingRecipesAvailable(param1:Vector.<int>) : void
      {
         _container.connection.send(new GetCraftingRecipesAvailableComposer(var_1105,param1));
      }
      
      private function onCraftingRecipesAvailableMessage(param1:CraftingRecipesAvailableMessageEvent) : void
      {
         var_16.infoCtrl.craftingSecretRecipesAvailable(param1.getParser().count,param1.getParser().recipeComplete);
      }
      
      public function doCraftingWithRecipe() : void
      {
         if(!var_3252 || !var_2539)
         {
            return;
         }
         var_16.infoCtrl.setState(1000);
         registerForFurniListInvalidate();
         _container.connection.send(new CraftComposer(var_1105,var_2539));
      }
      
      public function doCraftingWithMixer() : void
      {
         var_16.infoCtrl.setState(1000);
         var _loc1_:Vector.<int> = var_16.getSelectedIngredients();
         registerForFurniListInvalidate();
         _container.connection.send(new CraftSecretComposer(var_1105,_loc1_));
      }
      
      private function onCraftingResultMessage(param1:CraftingResultMessageEvent) : void
      {
         _craftingInProgress = false;
         if(!param1.getParser().success)
         {
            var_16.clearMixerItems();
            var_1789 = false;
            removeInventoryUpdateEvent();
            var_16.setInfoState(1);
            return;
         }
         var_16.clearMixerItems();
         var _loc2_:class_2398 = param1.getParser().productData;
         var _loc3_:class_1800 = _container.sessionDataManager.getFloorItemDataByName(null.furnitureClassName);
      }
      
      private function registerForFurniListInvalidate() : void
      {
         var_1789 = true;
         if(var_1701 == null)
         {
            var_1701 = new FurniListInvalidateEvent(onFurniListInvalidate);
            _container.connection.addMessageEvent(var_1701);
         }
      }
      
      private function onFurniListInvalidate(param1:FurniListInvalidateEvent) : void
      {
         _container.connection.send(new RequestFurniInventoryComposer());
         _container.connection.send(new GetCraftableProductsComposer(var_1105));
         removeInventoryUpdateEvent();
      }
      
      public function removeInventoryUpdateEvent() : void
      {
         if(var_1701)
         {
            _container.connection.removeMessageEvent(var_1701);
            var_1701 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_CRAFTING";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         addMessageEvents();
         if(_container.inventory && _container.inventory.events)
         {
            _container.inventory.events.addEventListener("HFLPE_FURNI_LIST_PARSED",onFurniListParsed);
         }
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function set widget(param1:CraftingWidget) : void
      {
         var_16 = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         return null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RETWE_OPEN_WIDGET","RETWE_CLOSE_WIDGET"];
      }
      
      public function processEvent(param1:Event) : void
      {
         if(_container.roomEngine == null || var_16 == null)
         {
            return;
         }
         var _loc3_:RoomEngineToWidgetEvent = param1 as RoomEngineToWidgetEvent;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IRoomObject = _container.roomEngine.getRoomObject(_loc3_.roomId,_loc3_.objectId,_loc3_.category);
         switch(param1.type)
         {
            case "RETWE_OPEN_WIDGET":
               if(var_16.window != null)
               {
                  return;
               }
               if(_loc2_ != null)
               {
                  var_1105 = _loc2_.getId();
                  initializeData();
               }
               break;
            case "RETWE_CLOSE_WIDGET":
               var_1105 = -1;
               var_16.hide();
         }
      }
      
      public function get isOwner() : Boolean
      {
         var _loc1_:int = _container.roomEngine.activeRoomId;
         var _loc2_:IRoomObject = _container.roomEngine.getRoomObject(_loc1_,var_1105,10);
         return _loc2_ != null && _container.isOwnerOfFurniture(_loc2_);
      }
      
      public function get craftingInProgress() : Boolean
      {
         return _craftingInProgress;
      }
      
      public function set craftingInProgress(param1:Boolean) : void
      {
         _craftingInProgress = param1;
      }
      
      public function get inventoryDirty() : Boolean
      {
         return var_1789;
      }
      
      public function update() : void
      {
      }
   }
}

