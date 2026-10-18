--
---@alias u8 integer
---@alias u16 integer
---@alias u32 integer
---@alias u64 integer

---@alias f8 integer
---@alias f16 integer
---@alias f32 integer
---@alias f64 integer

---@class TimeZone

---@generic T : TimeZone
---@class Time<T>
---@field unix? f64 | nil
---@field year? Time<T> | nil
---@field month Time<T> | nil
---@field day? u8 | nil
---@field hour? Time<T> | nil
---@field minute? Time<T> | nil
---@field second? Time<T> | nil
---@field format? fun(self: Time<T>, fmt: table): Time<T> | nil

---@class Locale<T>
---@field day? T
---@field year? T
---@field month? T
---@field hour12? T
---@field hour24? T
---@field hour_am_pm? T
---@field minute? T
---@field second? T

---@class StatKind

---@class StatMode

---@class Stat
---@field kind? StatKind | nil
---@field mode? StatMode| integer | nil
---@field len? u64 | nil
---@field atime? Time | nil
---@field btime? Time | nil
---@field ctime? Time | nil
---@field mtime? Time | nil
---@field dev? u64 | nil
---@field uid? u32 | nil
---@field gid? u32 | nil
---@field nlink? u64 | nil

---@generic T
---@class Buildable
---@field new fun(t: Time): T
---@field build fun(self: T): string
---@field sep? string

---@class datetime : Buildable
---@field year? string
---@field month? string
---@field day? string
---@field new fun(t: Time): datetime
---@field build fun(self: datetime): string

---@class timestamp : Buildable
---@field hours_fmt TimeStampFormat
---@field hour12? string | osdate
---@field hour24? string  | osdate
---@field minute? string | osdate
---@field am_or_pm? TimeStampAmPm
---@field new fun(t: Time, fmt?: TimeStampFormat): timestamp
---@field build fun(self: timestamp, fmt?: TimeStampFormat): string
---
---@field build_twelve fun(self: timestamp): string Returns a 12-hour formatted timestamp string
---@field build_military fun(self: timestamp): string Returns a 24-hour formatted timestamp string

---@class shape : Buildable
---@field sep string
---@field date_component datetime
---@field timestamp_component timestamp
---@field new fun(t: Time, fmt?: TimeStampFormat): shape Defaults to 12-hour fmt'ing
---@field build fun(self: shape): string
