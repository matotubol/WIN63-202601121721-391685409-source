package com.sulake.habbo.game
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
   import flash.events.IEventDispatcher;
   
   public interface class_45 extends IUnknown
   {
      
      function initGameDirectoryConnection() : void;
      
      function startSnowWarGame(param1:String) : void;
      
      function startQuickSnowWarGame() : void;
      
      function onSnowWarArenaSessionEnded() : void;
      
      function get events() : IEventDispatcher;
      
      function handleClickOnTile(param1:RoomObjectTileMouseEvent) : void;
      
      function handleClickOnHuman(param1:int, param2:Boolean, param3:Boolean) : void;
      
      function generateChecksumMismatch() : void;
      
      function handleMouseOverOnHuman(param1:int, param2:Boolean, param3:Boolean) : void;
      
      function get gameCenterEnabled() : Boolean;
      
      function get isHotelClosed() : Boolean;
   }
}

