cache_server
=====

An OTP library

1. �������� ���������� ������:
{ok, Pid} = cache_server:start_link([{drop_interval, 3600}]).
ok = cache_server:insert(Key, Value, 600). %% ����, ��������, ����� ����� ������
{ok, Value} = cache_server:lookup(Key).
DateFrom = {{2015,1,1},{00,00,00}}.
DateTo = {{2015,1,10},{23,59,59}}.
{ok, Value} = cache_server:lookup_by_date(DateFrom, DateTo).
������ ������ ������� ������ �� ���������� ������� ������ ���� ������� ��� ������.
�������� ������� ���������� ������ ����������� ��� ������ (drop_interval). �����
�������� � ��������.

Build
-----

    $ rebar3 compile
