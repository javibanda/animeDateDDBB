create table public."user"
(
    id        uuid primary key not null,
    user_name character varying(100),
    email     character varying(1000),
    password  character varying(1000),
    role      character varying(50)
);


create table public.admin_user
(
    email varchar(500) not null
        primary key
);


create table public.anime
(
    name           character varying(200) primary key not null,
    favorite_count integer default 0
);


create table public.anime_character
(
    name      character varying(200) primary key not null,
    url_photo text,
    anime     character varying(200)             not null,
    sex       character varying(20)              not null default 'MALE',
    foreign key (anime) references public.anime (name)
        match simple on update no action on delete no action
);


create table public.profile
(
    id                 uuid primary key       not null,
    sex                character varying(20)  not null,
    favorite_anime     character varying(200) not null,
    favorite_character character varying(200) not null,
    sexual_orientation character varying(200) not null,
    waifu              character varying(200) not null,
    bio                text,
    what_search        character varying(200) not null,
    user_id            uuid                   not null,
    is_cosplayer       boolean                not null default true,
    birth_date         date                   not null,
    name               character varying(200),
    foreign key (user_id) references public."user" (id)
        match simple on update no action on delete no action,
    foreign key (favorite_anime) references public.anime (name)
        match simple on update no action on delete no action,
    foreign key (favorite_character) references public.anime_character (name)
        match simple on update no action on delete no action,
    foreign key (waifu) references public.anime_character (name)
        match simple on update no action on delete no action
);
create unique index profile_user_id_key on profile using btree (user_id);


create table public.anime_profile
(
    id         uuid primary key       not null,
    id_profile uuid                   not null,
    anime      character varying(200) not null,
    foreign key (id_profile) references public.profile (id)
        match simple on update no action on delete no action,
    foreign key (anime) references public.anime (name)
        match simple on update no action on delete no action
);


create table public.user_photo
(
    id         uuid primary key            not null,
    path       character varying(1000)     not null,
    date       timestamp without time zone not null,
    profile_id uuid                        not null,
    "order"    integer                     not null,
    foreign key (profile_id) references public.profile (id)
        match simple on update no action on delete no action
);


create table public.match
(
    id              uuid primary key not null,
    profile_id_1    uuid             not null,
    profile_id_2    uuid             not null,
    match_profile_1 boolean          not null,
    match_profile_2 boolean,
    matched_at      timestamp without time zone default CURRENT_TIMESTAMP,
    is_block        boolean                     default false,
    blocked_by      uuid,
    blocking_reason text,
    stop_follow     boolean                     default false,
    foreign key (profile_id_1) references public.profile (id)
        match simple on update no action on delete no action,
    foreign key (profile_id_2) references public.profile (id)
        match simple on update no action on delete no action
);









