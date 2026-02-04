package com.sulake.habbo.friendlist.domain
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.friendlist.HabboFriendList;
   import com.sulake.habbo.friendlist.ITabView;
   
   public class FriendListTab
   {
      
      private var var_197:int;
      
      private var _name:String;
      
      private var _footerName:String;
      
      private var _headerPicName:String;
      
      private var var_3526:ITabView;
      
      private var var_1912:Boolean;
      
      private var _selected:Boolean;
      
      private var var_18:class_1812;
      
      public function FriendListTab(param1:HabboFriendList, param2:int, param3:ITabView, param4:String, param5:String, param6:String)
      {
         super();
         var_197 = param2;
         _name = param4;
         var_3526 = param3;
         _footerName = param5;
         _headerPicName = param6;
         var_3526.init(param1);
      }
      
      public function setSelected(param1:Boolean) : void
      {
         if(param1)
         {
            var_1912 = false;
         }
         _selected = param1;
      }
      
      public function setNewMessageArrived(param1:Boolean) : void
      {
         if(selected)
         {
            var_1912 = false;
         }
         else
         {
            var_1912 = param1;
         }
      }
      
      public function get newMessageArrived() : Boolean
      {
         return var_1912;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get footerName() : String
      {
         return _footerName;
      }
      
      public function get headerPicName() : String
      {
         return _headerPicName;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get tabView() : ITabView
      {
         return var_3526;
      }
      
      public function get view() : class_1812
      {
         return var_18;
      }
      
      public function set view(param1:class_1812) : void
      {
         var_18 = param1;
      }
   }
}

