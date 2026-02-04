package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.room.object.IRoomObjectModelController;
   
   public class FurniturePlanetSystemLogic extends class_1738
   {
      
      public function FurniturePlanetSystemLogic()
      {
         super();
      }
      
      override public function initialize(param1:XML) : void
      {
         var _loc3_:IRoomObjectModelController = null;
         super.initialize(param1);
         if(param1 == null)
         {
            return;
         }
         var _loc2_:XMLList = param1.planetsystem;
         if(_loc2_.length() == 0)
         {
            return;
         }
         if(object != null)
         {
            _loc3_ = object.getModelController();
            if(_loc3_ != null)
            {
               _loc3_.setString("furniture_planetsystem_data",String(_loc2_));
            }
         }
      }
   }
}

