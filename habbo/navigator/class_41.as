package com.sulake.habbo.navigator
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1945;
   
   public interface class_41 extends IUnknown
   {
      
      function get events() : IEventDispatcher;
      
      function goToHomeRoom() : Boolean;
      
      function performTagSearch(param1:String) : void;
      
      function performTextSearch(param1:String) : void;
      
      function performGuildBaseSearch() : void;
      
      function performCompetitionRoomsSearch(param1:int, param2:int) : void;
      
      function showOwnRooms() : void;
      
      function goToPrivateRoom(param1:int) : void;
      
      function hasRoomRightsButIsNotOwner(param1:int) : Boolean;
      
      function removeRoomRights(param1:int) : void;
      
      function goToRoomNetwork(param1:int, param2:Boolean) : void;
      
      function startRoomCreation() : void;
      
      function openNavigator(param1:Point = null) : void;
      
      function closeNavigator() : void;
      
      function get homeRoomId() : int;
      
      function get enteredGuestRoomData() : class_1945;
      
      function showToolbarHover(param1:Point) : void;
      
      function hideToolbarHover(param1:Boolean) : void;
      
      function toggleRoomInfoVisibility() : void;
      
      function canRateRoom() : Boolean;
      
      function isRoomFavorite(param1:int) : Boolean;
      
      function isRoomHome(param1:int) : Boolean;
      
      function get visibleEventCategories() : Array;
   }
}

