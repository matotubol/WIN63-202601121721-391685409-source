package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import flash.display.BitmapData;
   
   public class InfoStandFurniData
   {
      
      private var var_197:int = 0;
      
      private var var_191:int = 0;
      
      private var _name:String = "";
      
      private var var_735:String = "";
      
      private var var_48:BitmapData;
      
      private var var_1015:int;
      
      private var var_4146:int = -1;
      
      private var var_744:String = "";
      
      private var var_1966:IStuffData = null;
      
      private var _groupId:int;
      
      private var var_1820:int = 0;
      
      private var _ownerName:String = "";
      
      private var var_4443:int = -1;
      
      private var var_3918:Boolean = false;
      
      private var var_4013:int = -1;
      
      public function InfoStandFurniData()
      {
         super();
      }
      
      public function set id(param1:int) : void
      {
         var_197 = param1;
      }
      
      public function set category(param1:int) : void
      {
         var_191 = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set description(param1:String) : void
      {
         var_735 = param1;
      }
      
      public function set image(param1:BitmapData) : void
      {
         var_48 = param1;
      }
      
      public function set classId(param1:int) : void
      {
         var_1015 = param1;
      }
      
      public function set purchaseOfferId(param1:int) : void
      {
         var_4146 = param1;
      }
      
      public function set bcOfferId(param1:int) : void
      {
         var_4013 = param1;
      }
      
      public function set extraParam(param1:String) : void
      {
         var_744 = param1;
      }
      
      public function set stuffData(param1:IStuffData) : void
      {
         var_1966 = param1;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function set ownerId(param1:int) : void
      {
         var_1820 = param1;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function set availableForBuildersClub(param1:Boolean) : void
      {
         var_3918 = param1;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function get classId() : int
      {
         return var_1015;
      }
      
      public function get image() : BitmapData
      {
         return var_48;
      }
      
      public function get purchaseOfferId() : int
      {
         return var_4146;
      }
      
      public function get bcOfferId() : int
      {
         return var_4013;
      }
      
      public function get extraParam() : String
      {
         return var_744;
      }
      
      public function get stuffData() : IStuffData
      {
         return var_1966;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get ownerId() : int
      {
         return var_1820;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get rentOfferId() : int
      {
         return var_4443;
      }
      
      public function set rentOfferId(param1:int) : void
      {
         var_4443 = param1;
      }
      
      public function get availableForBuildersClub() : Boolean
      {
         return var_3918;
      }
      
      public function setData(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         id = param1.id;
         category = param1.category;
         name = param1.name;
         description = param1.description;
         image = param1.image;
         purchaseOfferId = param1.purchaseOfferId;
         extraParam = param1.extraParam;
         stuffData = param1.stuffData;
         groupId = param1.groupId;
         ownerName = param1.ownerName;
         ownerId = param1.ownerId;
         rentOfferId = param1.rentOfferId;
         availableForBuildersClub = param1.availableForBuildersClub;
         classId = param1.classId;
         bcOfferId = param1.bcOfferId;
      }
   }
}

