package com.sulake.habbo.room.object
{
   import flash.utils.Dictionary;
   
   public class RoomObjectUserTypes
   {
      
      public static const USER:String = "user";
      
      public static const PET:String = "pet";
      
      public static const BOT:String = "bot";
      
      public static const RENTABLE_BOT:String = "rentable_bot";
      
      public static const MONSTERPLANT:String = "monsterplant";
      
      private static const const_11:Dictionary = new Dictionary();
      
      const_11["user"] = 1;
      const_11["pet"] = 2;
      const_11["bot"] = 3;
      const_11["rentable_bot"] = 4;
      
      public function RoomObjectUserTypes()
      {
         super();
      }
      
      public static function getTypeId(param1:String) : int
      {
         return const_11[param1];
      }
      
      public static function getName(param1:int) : String
      {
         for(var _loc2_ in const_11)
         {
            if(const_11[_loc2_] == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getVisualizationType(param1:String) : String
      {
         switch(param1)
         {
            case "bot":
            case "rentable_bot":
               return "user";
            default:
               return param1;
         }
      }
   }
}

