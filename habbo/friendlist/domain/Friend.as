package com.sulake.habbo.friendlist.domain
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.friendlist.class_1927;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_2083;
   
   public class Friend implements class_1927, class_13
   {
      
      public static const GENDER_FEMALE:int = "F".charCodeAt(0);
      
      public static const GENDER_MALE:int = "M".charCodeAt(0);
      
      private var var_197:int;
      
      private var _name:String;
      
      private var var_111:int;
      
      private var var_3279:Boolean;
      
      private var var_3136:Boolean;
      
      private var var_975:String;
      
      private var var_3144:String;
      
      private var var_2995:String;
      
      private var var_2851:int;
      
      private var _selected:Boolean;
      
      private var _disposed:Boolean;
      
      private var var_18:class_1812;
      
      private var var_664:BitmapData;
      
      private var _realName:String;
      
      private var var_3260:Boolean;
      
      private var var_3259:Boolean;
      
      private var var_2731:Boolean;
      
      private var _relationshipStatus:int;
      
      public function Friend(param1:class_2083)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         var_197 = param1.id;
         _name = param1.name;
         var_111 = param1.gender;
         var_3279 = param1.online;
         var_3136 = param1.followingAllowed && param1.online;
         var_975 = param1.figure;
         var_3144 = param1.motto;
         var_2995 = param1.lastAccess;
         var_2851 = 0;
         _realName = param1.realName;
         var_3260 = param1.persistedMessageUser;
         var_2731 = param1.vipMember;
         var_3259 = param1.pocketHabboUser;
         _relationshipStatus = param1.relationshipStatus;
         class_21.log("Creating friend: " + id + ", " + name + ", " + gender + ", " + online + ", " + followingAllowed + ", " + figure + ", " + categoryId);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_664 != null)
         {
            var_664.dispose();
            var_664 = null;
         }
         _disposed = true;
         var_18 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get gender() : int
      {
         return var_111;
      }
      
      public function get online() : Boolean
      {
         return var_3279;
      }
      
      public function get followingAllowed() : Boolean
      {
         return var_3136;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get motto() : String
      {
         return var_3144;
      }
      
      public function get lastAccess() : String
      {
         return var_2995;
      }
      
      public function get categoryId() : int
      {
         return var_2851;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get view() : class_1812
      {
         return var_18;
      }
      
      public function get face() : BitmapData
      {
         return var_664;
      }
      
      public function get realName() : String
      {
         return _realName;
      }
      
      public function get persistedMessageUser() : Boolean
      {
         return var_3260;
      }
      
      public function get pocketHabboUser() : Boolean
      {
         return var_3259;
      }
      
      public function get relationshipStatus() : int
      {
         return _relationshipStatus;
      }
      
      public function get vipMember() : Boolean
      {
         return var_2731;
      }
      
      public function set id(param1:int) : void
      {
         var_197 = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set gender(param1:int) : void
      {
         var_111 = param1;
      }
      
      public function set online(param1:Boolean) : void
      {
         var_3279 = param1;
      }
      
      public function set followingAllowed(param1:Boolean) : void
      {
         var_3136 = param1;
      }
      
      public function set figure(param1:String) : void
      {
         var_975 = param1;
      }
      
      public function set motto(param1:String) : void
      {
         var_3144 = param1;
      }
      
      public function set lastAccess(param1:String) : void
      {
         var_2995 = param1;
      }
      
      public function set categoryId(param1:int) : void
      {
         var_2851 = param1;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
      }
      
      public function set view(param1:class_1812) : void
      {
         var_18 = param1;
      }
      
      public function set face(param1:BitmapData) : void
      {
         var_664 = param1;
      }
      
      public function set realName(param1:String) : void
      {
         _realName = param1;
      }
      
      public function set persistedMessageUser(param1:Boolean) : void
      {
         var_3260 = param1;
      }
      
      public function set pocketHabboUser(param1:Boolean) : void
      {
         var_3259 = param1;
      }
      
      public function set vipMember(param1:Boolean) : void
      {
         var_2731 = param1;
      }
      
      public function isGroupFriend() : Boolean
      {
         return var_197 < 0;
      }
   }
}

