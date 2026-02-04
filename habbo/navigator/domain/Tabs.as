package com.sulake.habbo.navigator.domain
{
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.mainview.*;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.*;
   import flash.utils.Dictionary;
   
   public class Tabs
   {
      
      public static const TAB_EVENTS:int = 1;
      
      public static const TAB_ROOMS:int = 2;
      
      public static const TAB_ME:int = 3;
      
      public static const TAB_OFFICIAL:int = 4;
      
      public static const TAB_SEARCH:int = 5;
      
      public static const TAB_CATEGORIES:int = 6;
      
      public static const SEARCHTYPE_POPULAR_ROOMS:int = 1;
      
      public static const SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE:int = 2;
      
      public static const SEARCHTYPE_MY_FRIENDS_ROOMS:int = 3;
      
      public static const SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE:int = 4;
      
      public static const SEARCHTYPE_MY_ROOMS:int = 5;
      
      public static const SEARCHTYPE_MY_FAVOURITES:int = 6;
      
      public static const const_137:int = 7;
      
      public static const SEARCHTYPE_TEXT_SEARCH:int = 8;
      
      public static const SEARCHTYPE_TAG_SEARCH:int = 9;
      
      public static const SEARCHTYPE_ROOM_NAME_SEARCH:int = 10;
      
      public static const SEARCHTYPE_OFFICIALROOMS:int = 11;
      
      public static const const_1122:int = 12;
      
      public static const SEARCHTYPE_GROUP_NAME_SEARCH:int = 13;
      
      public static const SEARCHTYPE_GUILD_BASES:int = 14;
      
      public static const SEARCHTYPE_COMPETITION_ROOMS:int = 15;
      
      public static const const_285:int = 16;
      
      public static const const_122:int = 17;
      
      public static const const_1167:int = 18;
      
      public static const SEARCHTYPE_MY_GUILD_BASES:int = 19;
      
      public static const SEARCHTYPE_BY_OWNER:int = 20;
      
      public static const SEARCHTYPE_CATEGORIES:int = 21;
      
      public static const SEARCHTYPE_RECOMMENDED_ROOMS:int = 22;
      
      public static const const_687:int = 23;
      
      private static const TAB_NAMES:Dictionary = new Dictionary();
      
      TAB_NAMES["popular"] = 2;
      TAB_NAMES["official"] = 4;
      TAB_NAMES["me"] = 3;
      TAB_NAMES["events"] = 1;
      TAB_NAMES["search"] = 5;
      TAB_NAMES["categories"] = 6;
      
      private var var_817:Array;
      
      private var _navigator:HabboNavigator;
      
      public function Tabs(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var_817 = [];
         var_817.push(new Tab(_navigator,1,16,new EventsTabPageDecorator(_navigator),1));
         var_817.push(new Tab(_navigator,6,21,new CategoriesTabPageDecorator(_navigator),5));
         var_817.push(new Tab(_navigator,2,1,new RoomsTabPageDecorator(_navigator),1));
         var_817.push(new Tab(_navigator,4,11,new OfficialTabPageDecorator(_navigator),4));
         var_817.push(new Tab(_navigator,3,5,new MyRoomsTabPageDecorator(_navigator),1));
         var_817.push(new Tab(_navigator,5,8,new SearchTabPageDecorator(_navigator),2));
         setSelectedTab(1);
      }
      
      public static function tabIdFromName(param1:String, param2:int) : int
      {
         return param1 in TAB_NAMES ? TAB_NAMES[param1] : param2;
      }
      
      public function onFrontPage() : Boolean
      {
         return this.getSelected().id == 4;
      }
      
      public function get tabs() : Array
      {
         return var_817;
      }
      
      public function setSelectedTab(param1:int) : void
      {
         var _loc2_:Tab = getTab(param1);
         if(_loc2_ != null)
         {
            this.clearSelected();
            _loc2_.selected = true;
         }
      }
      
      public function getSelected() : Tab
      {
         for each(var _loc1_ in var_817)
         {
            if(_loc1_.selected)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      private function clearSelected() : void
      {
         for each(var _loc1_ in var_817)
         {
            _loc1_.selected = false;
         }
      }
      
      public function getTab(param1:int) : Tab
      {
         for each(var _loc2_ in var_817)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

