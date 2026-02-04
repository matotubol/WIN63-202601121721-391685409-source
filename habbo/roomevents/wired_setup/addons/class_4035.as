package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   
   public class class_4035 extends DefaultAddonType
   {
      
      private var _cont:class_1812;
      
      public function class_4035()
      {
         super();
      }
      
      private static function getIntState(param1:class_1885) : int
      {
         return param1.isSelected ? 1 : 0;
      }
      
      private static function select(param1:class_1885, param2:Boolean) : void
      {
         if(param2)
         {
            param1.select();
         }
         else
         {
            param1.unselect();
         }
      }
      
      override public function get code() : int
      {
         return class_4074.var_5314;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         _cont = cont;
         select(getKeepAltitudeInput(),param1.getBoolean(0));
         select(getMoveThroughFurniCheckbox(),param1.getBoolean(1));
         select(getMoveThroughUsersCheckbox(),param1.getBoolean(2));
         select(getBlockByFurniCheckbox(),param1.getBoolean(3));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getIntState(getKeepAltitudeInput()));
         _loc1_.push(getIntState(getMoveThroughFurniCheckbox()));
         _loc1_.push(getIntState(getMoveThroughUsersCheckbox()));
         _loc1_.push(getIntState(getBlockByFurniCheckbox()));
         return _loc1_;
      }
      
      private function getKeepAltitudeInput() : class_1885
      {
         return class_1885(_cont.findChildByName("keep_altitude_checkbox"));
      }
      
      private function getMoveThroughFurniCheckbox() : class_1885
      {
         return class_1885(_cont.findChildByName("move_through_furni_checkbox"));
      }
      
      private function getMoveThroughUsersCheckbox() : class_1885
      {
         return class_1885(_cont.findChildByName("move_through_users_checkbox"));
      }
      
      private function getBlockByFurniCheckbox() : class_1885
      {
         return class_1885(_cont.findChildByName("block_by_furni_checkbox"));
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.physics." + param1;
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title.physics." + param1;
      }
   }
}

