package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class class_1864
   {
      
      private var _groupId:int;
      
      private var _groupName:String;
      
      private var var_4458:int;
      
      private var var_2806:String;
      
      private var var_3474:int;
      
      private var var_80:Array;
      
      private var var_4831:Boolean;
      
      private var var_3774:int;
      
      private var var_2109:int;
      
      private var var_857:int;
      
      private var var_847:String;
      
      private var var_2334:Dictionary = new Dictionary();
      
      public function class_1864(param1:IMessageDataWrapper)
      {
         super();
         _groupId = param1.readInteger();
         _groupName = param1.readString();
         var_4458 = param1.readInteger();
         var_2806 = param1.readString();
         var_3474 = param1.readInteger();
         var_80 = [];
         var _loc2_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc2_)
         {
            var _loc3_:class_1893 = new class_1893(param1);
            var_80.push(null);
            var_2334[null.userId] = null;
            _loc4_++;
         }
         var_4831 = param1.readBoolean();
         var_3774 = param1.readInteger();
         var_2109 = param1.readInteger();
         var_857 = param1.readInteger();
         var_847 = param1.readString();
      }
      
      private static function removeFromArray(param1:int, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:class_1893 = null;
         while(_loc4_ < param2.length)
         {
            _loc3_ = param2[_loc4_];
            if(_loc3_.userId == param1)
            {
               param2.splice(_loc4_,1);
            }
            else
            {
               _loc4_++;
            }
         }
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function get baseRoomId() : int
      {
         return var_4458;
      }
      
      public function get badgeCode() : String
      {
         return var_2806;
      }
      
      public function get totalEntries() : int
      {
         return var_3474;
      }
      
      public function get pageSize() : int
      {
         return var_3774;
      }
      
      public function get pageIndex() : int
      {
         return var_2109;
      }
      
      public function get searchType() : int
      {
         return var_857;
      }
      
      public function get entries() : Array
      {
         return var_80;
      }
      
      public function get allowedToManage() : Boolean
      {
         return var_4831;
      }
      
      public function get userNameFilter() : String
      {
         return var_847;
      }
      
      public function get totalPages() : int
      {
         return Math.max(1,Math.ceil(var_3474 / var_3774));
      }
      
      public function update(param1:class_1893) : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_1893 = null;
         var_2334[param1.userId] = param1;
         while(_loc3_ < var_80.length)
         {
            _loc2_ = var_80[_loc3_];
            if(_loc2_.userId == param1.userId)
            {
               var_80[_loc3_] = param1;
               return;
            }
            _loc3_++;
         }
         var_80.push(param1);
      }
      
      public function remove(param1:int) : void
      {
         removeFromArray(param1,var_80);
         delete var_2334[param1];
      }
      
      public function getUser(param1:int) : class_1893
      {
         return var_2334[param1];
      }
   }
}

