package com.sulake.habbo.room.object.logic.furniture
{
   public class FurnitureMultiHeightLogic extends FurnitureMultiStateLogic
   {
      
      public function FurnitureMultiHeightLogic()
      {
         super();
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         object.getModelController().setNumber("furniture_is_variable_height",1,true);
      }
   }
}

