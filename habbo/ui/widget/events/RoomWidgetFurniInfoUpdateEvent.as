package com.sulake.habbo.ui.widget.events
{
   import com.sulake.habbo.room.IStuffData;
   import flash.display.BitmapData;
   
   public class RoomWidgetFurniInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const FURNI:String = "RWFIUE_FURNI";
      
      private var var_197:int = 0;
      
      private var var_191:int = 0;
      
      private var _name:String = "";
      
      private var var_735:String = "";
      
      private var var_48:BitmapData = null;
      
      private var var_1015:int = 0;
      
      private var var_3022:Boolean = false;
      
      private var var_3881:Boolean = false;
      
      private var var_2507:Boolean = false;
      
      private var var_1873:int = 0;
      
      private var var_4473:Boolean = false;
      
      private var var_4362:int = -1;
      
      private var var_5392:int = -1;
      
      private var var_4146:int = -1;
      
      private var var_744:String = "";
      
      private var var_3219:Boolean = false;
      
      private var var_1966:IStuffData = null;
      
      private var _groupId:int = 0;
      
      private var var_1820:int = 0;
      
      private var _ownerName:String = "";
      
      private var var_4056:int = 0;
      
      private var var_5379:int = -1;
      
      private var var_4443:int = -1;
      
      private var _purchaseCouldBeUsedForBuyout:Boolean;
      
      private var _rentCouldBeUsedForBuyout:Boolean;
      
      private var var_3918:Boolean;
      
      private var var_4732:Boolean;
      
      private var var_4013:int = -1;
      
      public function RoomWidgetFurniInfoUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function set id(param1:int) : void
      {
         var_197 = param1;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function set category(param1:int) : void
      {
         var_191 = param1;
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set description(param1:String) : void
      {
         var_735 = param1;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function set image(param1:BitmapData) : void
      {
         var_48 = param1;
      }
      
      public function get image() : BitmapData
      {
         return var_48;
      }
      
      public function set isWallItem(param1:Boolean) : void
      {
         var_3022 = param1;
      }
      
      public function get isWallItem() : Boolean
      {
         return var_3022;
      }
      
      public function set isStickie(param1:Boolean) : void
      {
         var_3881 = param1;
      }
      
      public function get isStickie() : Boolean
      {
         return var_3881;
      }
      
      public function set isRoomOwner(param1:Boolean) : void
      {
         var_2507 = param1;
      }
      
      public function get isRoomOwner() : Boolean
      {
         return var_2507;
      }
      
      public function set roomControllerLevel(param1:int) : void
      {
         var_1873 = param1;
      }
      
      public function get roomControllerLevel() : int
      {
         return var_1873;
      }
      
      public function set isAnyRoomController(param1:Boolean) : void
      {
         var_4473 = param1;
      }
      
      public function get isAnyRoomController() : Boolean
      {
         return var_4473;
      }
      
      public function set expiration(param1:int) : void
      {
         var_4362 = param1;
      }
      
      public function get expiration() : int
      {
         return var_4362;
      }
      
      public function set purchaseOfferId(param1:int) : void
      {
         var_4146 = param1;
      }
      
      public function get purchaseOfferId() : int
      {
         return var_4146;
      }
      
      public function get bcOfferId() : int
      {
         return var_4013;
      }
      
      public function set bcOfferId(param1:int) : void
      {
         var_4013 = param1;
      }
      
      public function set extraParam(param1:String) : void
      {
         var_744 = param1;
      }
      
      public function get extraParam() : String
      {
         return var_744;
      }
      
      public function set isOwner(param1:Boolean) : void
      {
         var_3219 = param1;
      }
      
      public function get isOwner() : Boolean
      {
         return var_3219;
      }
      
      public function set stuffData(param1:IStuffData) : void
      {
         var_1966 = param1;
      }
      
      public function get stuffData() : IStuffData
      {
         return var_1966;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function set ownerId(param1:int) : void
      {
         var_1820 = param1;
      }
      
      public function get ownerId() : int
      {
         return var_1820;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set usagePolicy(param1:int) : void
      {
         var_4056 = param1;
      }
      
      public function get usagePolicy() : int
      {
         return var_4056;
      }
      
      public function set rentOfferId(param1:int) : void
      {
         var_4443 = param1;
      }
      
      public function get rentOfferId() : int
      {
         return var_4443;
      }
      
      public function get purchaseCouldBeUsedForBuyout() : Boolean
      {
         return _purchaseCouldBeUsedForBuyout;
      }
      
      public function set purchaseCouldBeUsedForBuyout(param1:Boolean) : void
      {
         _purchaseCouldBeUsedForBuyout = param1;
      }
      
      public function get rentCouldBeUsedForBuyout() : Boolean
      {
         return _rentCouldBeUsedForBuyout;
      }
      
      public function set rentCouldBeUsedForBuyout(param1:Boolean) : void
      {
         _rentCouldBeUsedForBuyout = param1;
      }
      
      public function get availableForBuildersClub() : Boolean
      {
         return var_3918;
      }
      
      public function set availableForBuildersClub(param1:Boolean) : void
      {
         var_3918 = param1;
      }
      
      public function get isNft() : Boolean
      {
         return var_4732;
      }
      
      public function set isNft(param1:Boolean) : void
      {
         var_4732 = param1;
      }
      
      public function get classId() : int
      {
         return var_1015;
      }
      
      public function set classId(param1:int) : void
      {
         var_1015 = param1;
      }
   }
}

