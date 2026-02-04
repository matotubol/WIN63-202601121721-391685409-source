package com.sulake.habbo.inventory.pets
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.window.class_38;
   import flash.events.Event;
   import package_105.class_2838;
   import package_161.class_3451;
   import package_55.class_3179;
   
   public class PetsModel implements IInventoryModel
   {
      
      private var var_55:HabboInventory;
      
      private var var_18:PetsView;
      
      private var _assets:class_40;
      
      private var _communication:class_57;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var var_708:class_55;
      
      private var var_2603:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      private var var_4672:Boolean;
      
      public function PetsModel(param1:HabboInventory, param2:class_38, param3:class_57, param4:class_40, param5:IRoomEngine, param6:IHabboCatalog)
      {
         super();
         var_55 = param1;
         _assets = param4;
         _communication = param3;
         _roomEngine = param5;
         _roomEngine.events.addEventListener("REOE_PLACED",onObjectPlaced);
         _catalog = param6;
         var_708 = new class_55();
         var_18 = new PetsView(this,param2,param4,param5);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_18)
            {
               var_18.dispose();
               var_18 = null;
            }
            if(_roomEngine)
            {
               if(_roomEngine.events)
               {
                  _roomEngine.events.removeEventListener("REOE_PLACED",onObjectPlaced);
               }
               _roomEngine = null;
            }
            if(var_708)
            {
               var_708.dispose();
               var_708 = null;
            }
            var_55 = null;
            _catalog = null;
            _assets = null;
            _communication = null;
            _disposed = true;
         }
      }
      
      public function get controller() : HabboInventory
      {
         return var_55;
      }
      
      public function isListInitialized() : Boolean
      {
         return var_4672;
      }
      
      public function setListInitialized() : void
      {
         var_4672 = true;
         var_18.updateState();
      }
      
      public function requestPetInventory() : void
      {
         if(_communication == null)
         {
            return;
         }
         var _loc1_:IConnection = _communication.connection;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.send(new class_3451());
      }
      
      public function get pets() : class_55
      {
         return var_708;
      }
      
      public function addPet(param1:class_2838) : void
      {
         if(var_708.add(param1.id,param1))
         {
            var_18.addPet(param1);
         }
         var_18.updateState();
      }
      
      public function updatePets(param1:class_55) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.getKeys();
         var _loc4_:Array = var_708.getKeys();
         var_55.setInventoryCategoryInit("pets");
         for each(_loc3_ in _loc4_)
         {
            if(_loc2_.indexOf(_loc3_) == -1)
            {
               var_708.remove(_loc3_);
               var_18.removePet(_loc3_);
            }
         }
         for each(_loc3_ in _loc2_)
         {
            if(_loc4_.indexOf(_loc3_) == -1)
            {
               var_708.add(_loc3_,param1.getValue(_loc3_));
               var_18.addPet(param1.getValue(_loc3_));
            }
         }
         setListInitialized();
      }
      
      public function removePet(param1:int) : void
      {
         var_708.remove(param1);
         var_18.removePet(param1);
         var_18.updateState();
      }
      
      public function requestInitialization() : void
      {
         requestPetInventory();
      }
      
      public function categorySwitch(param1:String) : void
      {
         if(param1 == "pets" && var_55.isVisible)
         {
            var_55.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_PETS"));
         }
      }
      
      public function getWindowContainer() : class_1812
      {
         return var_18.getWindowContainer();
      }
      
      public function closingInventoryView() : void
      {
         if(var_18.isVisible)
         {
            resetUnseenItems();
         }
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function placePetToRoom(param1:int, param2:Boolean = false) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:class_2838 = getPetById(param1);
         if(_loc5_ == null)
         {
            return false;
         }
         var _loc3_:String = null;
         if(_loc5_.typeId == 16)
         {
            if(_loc5_.level >= 7)
            {
               _loc3_ = "std";
            }
            else
            {
               _loc3_ = "grw" + _loc5_.level;
            }
         }
         if(var_55.roomSession.isRoomOwner)
         {
            _loc4_ = _loc5_.id * -1;
            var_2603 = _roomEngine.initializeRoomObjectInsert("inventory",_loc4_,100,2,_loc5_.figureString,null,-1,-1,_loc3_);
            var_55.closeView();
            return var_2603;
         }
         if(!var_55.roomSession.arePetsAllowed)
         {
            return false;
         }
         if(!param2)
         {
            _communication.connection.send(new class_3179(_loc5_.id,0,0));
         }
         return true;
      }
      
      public function updateView() : void
      {
         if(var_18 == null)
         {
            return;
         }
         var_18.update();
      }
      
      private function getPetById(param1:int) : class_2838
      {
         for each(var _loc2_ in var_708)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function onObjectPlaced(param1:Event) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_2603 && param1.type == "REOE_PLACED")
         {
            var_55.showView();
            var_2603 = false;
         }
      }
      
      public function get roomSession() : IRoomSession
      {
         return var_55.roomSession;
      }
      
      public function updatePetsAllowed() : void
      {
         var_18.update();
      }
      
      public function resetUnseenItems() : void
      {
         var_55.unseenItemTracker.resetCategory(3);
         var_55.updateUnseenItemCounts();
         var_18.update();
      }
      
      public function isUnseen(param1:int) : Boolean
      {
         return var_55.unseenItemTracker.isUnseen(3,param1);
      }
      
      public function removeUnseenFurniCounter(param1:int) : Boolean
      {
         if(isUnseen(param1))
         {
            var _loc2_:Boolean = var_55.unseenItemTracker.removeUnseen(3,param1);
         }
         return false;
      }
      
      public function selectItemById(param1:String) : void
      {
         var_18.selectById(int(param1));
      }
   }
}

