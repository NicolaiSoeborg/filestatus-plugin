VERSION = "1.0.0"

require('CRC32')

function preSave(view)
    if view.Buf.IsModified and view.Buf.AbsPath ~= "" then
        local fileBuf = GetFileBuf(view)
        local changeDetected = GetBufCRC32(fileBuf) ~= GetBufCRC32(view.Buf)
        view.Buf.IsModified = changeDetected -- update status ("+")

        return changeDetected
    end
    return true
end

function GetFileBuf(view)
    --[[ Use NewBuffer for OS independent file read.
         I need to use the abs path, as "path" will just return a pointer to view.Buf
         TODO: Calling NewBuf(..):ReOpen() will be slow for big files.
         I might also be able to do:
            local f = io.popen("cat " .. path)
            f:read("*all")                        ]]--
    local fileBuf = NewBuffer("", view.Buf.absPath)
    fileBuf:ReOpen()
    return fileBuf
end

function GetBufCRC32(buf)
    return CRC32.Hash( buf.LineArray:String() )
end

function PrintStatus()
    messenger:Message(
        "View CRC32: ", GetBufCRC32(CurView().Buf), ". ",
        "File CRC32: ", GetBufCRC32(GetFileBuf(CurView()))
    )
end

MakeCommand("filestatus", "filestatus.PrintStatus", 0)
