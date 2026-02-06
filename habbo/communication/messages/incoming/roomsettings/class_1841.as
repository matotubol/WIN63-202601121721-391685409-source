package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class class_1841
   {
      
      public static const const_69:int = 0;
      
      public static const const_98:int = 1;
      
      public static const const_95:int = 2;
      
      public static const const_107:int = 3;
      
      public static const const_83:int = 4;
      
      public static const const_384:int = 0;
      
      public static const const_143:int = 1;
      
      public static const const_689:int = 2;
      
      private var var_1951:int;
      
      private var _name:String;
      
      private var var_735:String;
      
      private var var_4157:int;
      
      private var var_2851:int;
      
      private var var_4089:int;
      
      private var var_4464:int;
      
      private var var_553:Array;
      
      private var var_2859:int;
      
      private var var_4615:Boolean;
      
      private var var_4228:Boolean;
      
      private var var_3972:Boolean;
      
      private var _hideWalls:Boolean;
      
      private var _wallThickness:int;
      
      private var _floorThickness:int;
      
      private var var_1891:Dictionary;
      
      private var var_1541:Array;
      
      private var var_5039:int;
      
      private var var_2674:Dictionary;
      
      private var var_1659:Array;
      
      private var var_2624:class_3348;
      
      private var var_2796:class_2164;
      
      private var var_4872:Boolean;
      
      private var var_4537:Boolean;
      
      public function class_1841()
      {
         super();
      }
      
      public static function getDoorModeLocalizationKey(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return "${navigator.door.mode.open}";
            case 1:
               return "${navigator.door.mode.closed}";
            case 2:
               return "${navigator.door.mode.password}";
            case 3:
               return "${navigator.door.mode.invisible}";
            case 4:
               return "${navigator.door.mode.noobs_only}";
            default:
               return "";
         }
      }
      
      public function get tradeMode() : int
      {
         return var_2859;
      }
      
      public function set tradeMode(param1:int) : void
      {
         var_2859 = param1;
      }
      
      public function get allowPets() : Boolean
      {
         return var_4615;
      }
      
      public function set allowPets(param1:Boolean) : void
      {
         var_4615 = param1;
      }
      
      public function get allowFoodConsume() : Boolean
      {
         return var_4228;
      }
      
      public function set allowFoodConsume(param1:Boolean) : void
      {
         var_4228 = param1;
      }
      
      public function get allowWalkThrough() : Boolean
      {
         return var_3972;
      }
      
      public function set allowWalkThrough(param1:Boolean) : void
      {
         var_3972 = param1;
      }
      
      public function get hideWalls() : Boolean
      {
         return _hideWalls;
      }
      
      public function set hideWalls(param1:Boolean) : void
      {
         _hideWalls = param1;
      }
      
      public function get wallThickness() : int
      {
         return _wallThickness;
      }
      
      public function set wallThickness(param1:int) : void
      {
         _wallThickness = param1;
      }
      
      public function get floorThickness() : int
      {
         return _floorThickness;
      }
      
      public function set floorThickness(param1:int) : void
      {
         _floorThickness = param1;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function set roomId(param1:int) : void
      {
         var_1951 = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function set description(param1:String) : void
      {
         var_735 = param1;
      }
      
      public function get doorMode() : int
      {
         return var_4157;
      }
      
      public function set doorMode(param1:int) : void
      {
         var_4157 = param1;
      }
      
      public function get categoryId() : int
      {
         return var_2851;
      }
      
      public function set categoryId(param1:int) : void
      {
         var_2851 = param1;
      }
      
      public function get maximumVisitors() : int
      {
         return var_4089;
      }
      
      public function set maximumVisitors(param1:int) : void
      {
         var_4089 = param1;
      }
      
      public function get maximumVisitorsLimit() : int
      {
         return var_4464;
      }
      
      public function set maximumVisitorsLimit(param1:int) : void
      {
         var_4464 = param1;
      }
      
      public function get tags() : Array
      {
         return var_553;
      }
      
      public function set tags(param1:Array) : void
      {
         var_553 = param1;
      }
      
      public function setFlatController(param1:int, param2:class_3362) : void
      {
         if(var_1891 != null)
         {
            var_1891[param1] = param2;
            var_1541 = null;
            var_5039 = param1;
         }
      }
      
      public function get roomModerationSettings() : class_3348
      {
         return var_2624;
      }
      
      public function set roomModerationSettings(param1:class_3348) : void
      {
         var_2624 = param1;
      }
      
      public function get controllersById() : Dictionary
      {
         return var_1891;
      }
      
      public function set controllersById(param1:Dictionary) : void
      {
         var_1891 = param1;
      }
      
      public function get controllerList() : Array
      {
         if(var_1541 == null)
         {
            var_1541 = [];
            for(var _loc1_ in var_1891)
            {
               var _loc3_:int = int(_loc1_);
               var _loc2_:class_3362 = var_1891[0];
            }
            var_1541.sortOn("userName",1);
         }
         return var_1541;
      }
      
      public function get highlightedUserId() : int
      {
         return var_5039;
      }
      
      public function setBannedUser(param1:int, param2:class_3550) : void
      {
         if(var_2674 == null)
         {
            var_2674 = new Dictionary();
         }
         else
         {
            var_1659 = null;
         }
         var_2674[param1] = param2;
      }
      
      public function get bannedUsersById() : Dictionary
      {
         return var_2674;
      }
      
      public function get bannedUsersList() : Array
      {
         if(var_1659 == null)
         {
            var_1659 = [];
            for each(var _loc1_ in var_2674)
            {
               var_1659.push(_loc1_);
            }
            var_1659.sortOn("userName",1);
         }
         return var_1659;
      }
      
      public function get chatSettings() : class_2164
      {
         return var_2796;
      }
      
      public function set chatSettings(param1:class_2164) : void
      {
         var_2796 = param1;
      }
      
      public function get allowNavigatorDynamicCats() : Boolean
      {
         return var_4872;
      }
      
      public function set allowNavigatorDynamicCats(param1:Boolean) : void
      {
         var_4872 = param1;
      }
      
      public function get hiddenByBc() : Boolean
      {
         return var_4537;
      }
      
      public function set hiddenByBc(param1:Boolean) : void
      {
         var_4537 = param1;
      }
   }
}

